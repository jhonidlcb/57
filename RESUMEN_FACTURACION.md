# Resumen de Integración de Facturación y SIFEN - SoftwarePar

Este documento resume el trabajo realizado para unificar la gestión de facturas administrativas con el flujo de aprobación de pagos y la integración fiscal de Paraguay (SIFEN).

## 1. Arquitectura de Moneda Dual
- **Manejo de Precios:** El sistema opera internamente en **USD** para presupuestos y contratos.
- **Conversión Fiscal:** Para el cumplimiento con la SET (SIFEN), los montos se convierten a **PYG** utilizando la tasa de cambio activa del sistema en el momento de la creación/aprobación.
- **Almacenamiento:** La tabla `invoices` almacena:
    - `amount`: Monto original en USD.
    - `totalAmount`: Monto convertido a PYG (snapshot fiscal).
    - `exchangeRateUsed`: La tasa utilizada para la conversión.

## 2. Flujo de Trabajo Administrativo
- **Creación:** El administrador crea una factura desde `InvoiceManagement.tsx` ingresando el monto en USD.
- **Verificación:** Se implementó un modal de revisión de comprobantes (`proofFileUrl`) que permite al admin visualizar la transferencia del cliente.
- **Aprobación e Invoicing:** Al hacer clic en "Aprobar y Generar Factura":
    1. Se valida el comprobante.
    2. Se llama a la API de **FacturaSend** para emitir el Documento Electrónico (DE).
    3. Se capturan el **CDC** (Clave de Acceso) y el **QR** de SIFEN.
    4. Se actualiza el estado de la factura a `paid`.

## 3. Integración SIFEN (FacturaSend)
- Ubicación: `server/facturasend.ts`.
- Lógica: Utiliza `tipoImpuesto=2` (Exento) y `ivaTipo=3` según requerimientos previos del proyecto.
- Secuenciación: Se gestiona a través de `boletaSequence` en la tabla `company_billing_info`.

## 4. Archivos Clave
- `server/storage.ts`: Lógica de base de datos para creación y conversión de moneda.
- `server/routes.ts`: Endpoints `/api/admin/invoices` y lógica de orquestación con FacturaSend.
- `client/src/pages/admin/InvoiceManagement.tsx`: Interfaz de usuario para la gestión total de facturas.
- `shared/schema.ts`: Definición de las tablas `invoices`, `exchange_rate_config` y `company_billing_info`.

## Notas Pendientes y Errores Conocidos
- **Boton "+" de Edición:** El botón de edición (icono "+" al lado de cada factura) en `InvoiceManagement.tsx` actualmente abre un diálogo vacío o no realiza ninguna acción de guardado. Debe implementarse el formulario de edición (`showEditDialog`) para permitir corregir montos o fechas antes de la aprobación final.
- **Workflow de Aplicación:** Se detectó un fallo en el inicio de la aplicación que requiere revisión de los logs del servidor para asegurar que todos los servicios (FacturaSend, DB) estén respondiendo correctamente.
