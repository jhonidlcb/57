import type { FacturaSendDocumento, FacturaSendResponse } from "./facturasend";

const FACTURASEND_CONFIG = {
  apiKey: process.env.FACTURASEND_API_KEY,
  baseUrl: 'https://api.facturasend.com.py/jhonifabianbenitezdelacruz_9193',
};

const DATOS_DENIT = {
  ruc: '4220058',
  dv: '0',
  nombre: 'BENITEZ DE LA CRUZ JHONI FABIAN',
};

export async function enviarFacturaFacturaSend(documento: FacturaSendDocumento): Promise<FacturaSendResponse> {
  try {
    const apiKey = FACTURASEND_CONFIG.apiKey;
    if (!apiKey) {
      return { success: false, error: 'API Key no configurada' };
    }

    const payload = [{
      tipoDocumento: documento.tipoDocumento,
      establecimiento: documento.establecimiento,
      punto: documento.punto,
      numero: documento.numero,
      fecha: documento.fecha,
      tipoEmision: documento.tipoEmision,
      tipoTransaccion: documento.tipoTransaccion,
      tipoImpuesto: 2, // 2 = ISC/Exento (Alineado con prueba técnica exitosa)
      moneda: documento.moneda,
      observacion: documento.observacion,
      cliente: documento.cliente,
      usuario: documento.usuario,
      factura: documento.factura,
      condicion: documento.condicion,
      items: documento.items.map(item => {
        const total = Math.round(item.precioUnitario * item.cantidad);
        
        // Alineación total con el XML de la prueba técnica exitosa (tipoImpuesto=2, ivaTipo=3)
        // En este modo, el sistema de FacturaSend espera ivaBase=0 e iva=0 para exentos.
        return {
          descripcion: item.descripcion,
          cantidad: item.cantidad,
          unidadMedida: item.unidadMedida,
          precioUnitario: item.precioUnitario,
          ivaTipo: 3, // 3 = Exento
          ivaBase: 0, 
          iva: 0,
          ivaProporcion: 0,
          ...(item.codigo ? { codigo: item.codigo } : {})
        };
      })
    }];

    const jsonBody = JSON.stringify(payload);
    console.log('📦 Payload (Final):', jsonBody);

    const response = await fetch(`${FACTURASEND_CONFIG.baseUrl}/lote/create?xml=true&qr=true`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': `Bearer api_key_${apiKey}`
      },
      body: jsonBody
    });

    const result = await response.json();
    console.log('📡 Respuesta API:', JSON.stringify(result));
    return result;
  } catch (error: any) {
    return { success: false, error: error.message };
  }
}

export function extraerResultadoFacturaSend(response: FacturaSendResponse) {
  if (!response.success || !response.result?.deList?.[0]) {
    const apiError = (response as any).errores?.[0]?.error;
    const errorMsg = apiError || response.error || response.mensaje || 'Error en FacturaSend';
    return { 
      estado: 'rechazado', 
      mensaje: errorMsg
    };
  }
  const de = response.result.deList[0];
  return {
    cdc: de.cdc,
    qr: de.qr,
    estado: (de.estado === '0-Generado' || de.cdc) ? 'aceptado' : 'rechazado',
    mensaje: de.respuesta_mensaje || 'Documento procesado'
  };
}

export async function construirDocumentoFacturaSend(company: any, client: any, stage: any, project: any, exchangeRate: number, numero: number): Promise<FacturaSendDocumento> {
  const montoTotal = Math.round(parseFloat(stage.amount) * exchangeRate);
  
  // Limpieza estricta de RUC
  const rucOriginal = client.documentNumber || "";
  const isRuc = rucOriginal.includes('-');
  const documentoNumero = rucOriginal.split('-')[0].replace(/\D/g, '') || "44444401";

  return {
    tipoDocumento: 1,
    establecimiento: 1,
    punto: 1,
    numero,
    fecha: new Date().toISOString().split('.')[0],
    tipoEmision: 1,
    tipoTransaccion: 2,
    tipoImpuesto: 2, // 2 = ISC/Exento
    moneda: 'PYG',
    observacion: `Proyecto: ${project.name} - TC: ${exchangeRate}`,
    cliente: {
      contribuyente: isRuc,
      razonSocial: (client.legalName || 'CLIENTE').toUpperCase(),
      tipoOperacion: isRuc ? 1 : 2,
      direccion: "Barrio Residencial", 
      numeroCasa: "0",
      departamento: 8, 
      departamentoDescripcion: 'ITAPUA',
      distrito: 107, 
      distritoDescripcion: 'CARLOS A. LOPEZ',
      ciudad: 1456, 
      ciudadDescripcion: 'CARLOS A. LOPEZ',
      pais: 'PRY',
      paisDescripcion: 'Paraguay',
      tipoContribuyente: 1,
      documentoTipo: 1,
      documentoNumero: documentoNumero,
      ruc: isRuc ? rucOriginal : undefined
    },
    usuario: {
      documentoTipo: 1,
      documentoNumero: DATOS_DENIT.ruc,
      nombre: DATOS_DENIT.nombre,
      cargo: 'Propietario'
    },
    factura: { presencia: 1 },
    condicion: {
      tipo: 1,
      entregas: [{ tipo: 1, monto: montoTotal, moneda: 'PYG' }]
    },
    items: [{
      descripcion: stage.stageName.toUpperCase(),
      cantidad: 1,
      unidadMedida: 77,
      precioUnitario: montoTotal,
      ivaTipo: 3 // 3 = Exento
    }]
  };
}

export interface FacturaSendDocumento {
  tipoDocumento: number;
  establecimiento: number;
  punto: number;
  numero: number;
  fecha: string;
  tipoEmision: number;
  tipoTransaccion: number;
  tipoImpuesto: number;
  moneda: string;
  observacion?: string;
  cliente: any;
  usuario: any;
  factura: { presencia: number };
  condicion: { tipo: number; entregas: any[] };
  items: any[];
}

export interface FacturaSendResponse {
  success: boolean;
  result?: { deList: any[]; loteId: number };
  error?: string;
  mensaje?: string;
}
