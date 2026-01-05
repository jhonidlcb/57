
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { motion } from "framer-motion";
import DashboardLayout from "@/components/DashboardLayout";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { apiRequest } from "@/lib/api";
import {
  DollarSign,
  Plus,
  Eye,
  Download,
  CheckCircle,
  Clock,
  AlertCircle,
  Calendar,
  FileText,
  Trash2,
  ExternalLink,
  ShieldCheck,
} from "lucide-react";

interface Invoice {
  id: number;
  invoiceNumber: string;
  projectId: number;
  projectName: string;
  clientId: number;
  clientName: string;
  amount: string;
  totalAmount: string;
  status: 'pending' | 'paid' | 'overdue' | 'cancelled';
  dueDate: string;
  paidDate?: string;
  createdAt: string;
  proofFileUrl?: string;
  paymentMethod?: string;
  sifenCDC?: string;
  sifenQR?: string;
  description?: string;
}

interface Project {
  id: number;
  name: string;
  clientId: number;
  clientName: string;
  price: string;
}

export default function InvoiceManagement() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [showCreateDialog, setShowCreateDialog] = useState(false);
  const [showEditDialog, setShowEditDialog] = useState(false);
  const [showProofDialog, setShowProofDialog] = useState(false);
  const [selectedProject, setSelectedProject] = useState<Project | null>(null);
  const [editingInvoice, setEditingInvoice] = useState<Invoice | null>(null);
  const [viewingProof, setViewingProof] = useState<Invoice | null>(null);

  const { data: invoices, isLoading: invoicesLoading } = useQuery<Invoice[]>({
    queryKey: ["/api/admin/invoices"],
    queryFn: async () => {
      const response = await apiRequest("GET", "/api/admin/invoices");
      if (!response.ok) throw new Error('Error al cargar facturas');
      return await response.json();
    },
  });

  const { data: projects, isLoading: projectsLoading } = useQuery<Project[]>({
    queryKey: ["/api/admin/projects"],
    queryFn: async () => {
      const response = await apiRequest("GET", "/api/admin/projects");
      if (!response.ok) throw new Error('Error al cargar proyectos');
      return await response.json();
    },
  });

  const createInvoiceMutation = useMutation({
    mutationFn: async (data: any) => {
      const response = await apiRequest("POST", "/api/admin/invoices", data);
      if (!response.ok) throw new Error('Error al crear factura');
      return await response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/invoices"] });
      toast({ title: "Factura creada", description: "Se ha generado la factura correctamente." });
      setShowCreateDialog(false);
      setSelectedProject(null);
    },
  });

  const updateInvoiceMutation = useMutation({
    mutationFn: async ({ id, ...data }: any) => {
      const response = await apiRequest("PATCH", `/api/admin/invoices/${id}`, data);
      if (!response.ok) throw new Error('Error al actualizar factura');
      return await response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/invoices"] });
      toast({ title: "Factura actualizada", description: "Cambios guardados correctamente." });
      setShowEditDialog(false);
    },
  });

  const approvePaymentMutation = useMutation({
    mutationFn: async (id: number) => {
      const response = await apiRequest("POST", `/api/admin/invoices/${id}/approve`);
      if (!response.ok) {
        const err = await response.json();
        throw new Error(err.message || 'Error al aprobar pago');
      }
      return await response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["/api/admin/invoices"] });
      toast({ title: "Pago aprobado", description: "Factura SIFEN generada y enviada al cliente." });
      setShowProofDialog(false);
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    }
  });

  const getStatusBadge = (status: string) => {
    const configs: Record<string, { color: string, label: string }> = {
      paid: { color: "bg-green-100 text-green-800", label: "Pagado" },
      pending: { color: "bg-yellow-100 text-yellow-800", label: "Pendiente" },
      overdue: { color: "bg-red-100 text-red-800", label: "Vencido" },
      cancelled: { color: "bg-gray-100 text-gray-800", label: "Cancelado" },
    };
    const config = configs[status] || { color: "bg-gray-100", label: status };
    return <Badge className={config.color}>{config.label}</Badge>;
  };

  const stats = {
    total: invoices?.length || 0,
    pending: invoices?.filter(i => i.status === 'pending').length || 0,
    paid: invoices?.filter(i => i.status === 'paid').length || 0,
    revenue: invoices?.reduce((sum, i) => i.status === 'paid' ? sum + parseFloat(i.totalAmount || "0") : sum, 0) || 0,
  };

  if (invoicesLoading || projectsLoading) {
    return <DashboardLayout title="Gestión de Facturas"><div className="p-8">Cargando...</div></DashboardLayout>;
  }

  return (
    <DashboardLayout title="Facturación Administrativa">
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <h1 className="text-3xl font-bold tracking-tight">Facturas del Sistema</h1>
          <Button onClick={() => setShowCreateDialog(true)}>
            <Plus className="mr-2 h-4 w-4" /> Nueva Factura
          </Button>
        </div>

        <div className="grid gap-4 md:grid-cols-4">
          <Card><CardContent className="pt-6"><div className="text-2xl font-bold">{stats.total}</div><p className="text-xs text-muted-foreground">Total Emitidas</p></CardContent></Card>
          <Card><CardContent className="pt-6"><div className="text-2xl font-bold text-yellow-600">{stats.pending}</div><p className="text-xs text-muted-foreground">Pendientes</p></CardContent></Card>
          <Card><CardContent className="pt-6"><div className="text-2xl font-bold text-green-600">{stats.paid}</div><p className="text-xs text-muted-foreground">Pagadas</p></CardContent></Card>
          <Card><CardContent className="pt-6"><div className="text-2xl font-bold">Gs {stats.revenue.toLocaleString()}</div><p className="text-xs text-muted-foreground">Ingresos Totales (snapshot)</p></CardContent></Card>
        </div>

        <Card>
          <CardContent className="p-0">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Número / CDC</TableHead>
                  <TableHead>Cliente / Proyecto</TableHead>
                  <TableHead>Monto</TableHead>
                  <TableHead>Estado</TableHead>
                  <TableHead>Vencimiento</TableHead>
                  <TableHead className="text-right">Acciones</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {invoices?.map((invoice) => (
                  <TableRow key={invoice.id}>
                    <TableCell>
                      <div className="font-medium">{invoice.invoiceNumber}</div>
                      {invoice.sifenCDC && <div className="text-[10px] text-muted-foreground truncate max-w-[150px]">{invoice.sifenCDC}</div>}
                    </TableCell>
                    <TableCell>
                      <div className="font-medium">{invoice.clientName}</div>
                      <div className="text-xs text-muted-foreground">{invoice.projectName}</div>
                    </TableCell>
                    <TableCell>
                      <div className="font-bold">Gs {parseFloat(invoice.totalAmount || "0").toLocaleString()}</div>
                      <div className="text-[10px] text-muted-foreground">${parseFloat(invoice.amount || "0").toLocaleString()} USD</div>
                    </TableCell>
                    <TableCell>{getStatusBadge(invoice.status)}</TableCell>
                    <TableCell>{new Date(invoice.dueDate).toLocaleDateString()}</TableCell>
                    <TableCell className="text-right space-x-2">
                      {invoice.proofFileUrl && invoice.status === 'pending' && (
                        <Button variant="outline" size="sm" className="bg-blue-50 text-blue-700 border-blue-200" onClick={() => { setViewingProof(invoice); setShowProofDialog(true); }}>
                          <ShieldCheck className="h-4 w-4 mr-1" /> Verificar
                        </Button>
                      )}
                      <Button variant="ghost" size="icon" onClick={() => { setEditingInvoice(invoice); setShowEditDialog(true); }}>
                        <Plus className="h-4 w-4" />
                      </Button>
                      {invoice.sifenQR && (
                        <Button variant="ghost" size="icon" onClick={() => window.open(invoice.sifenQR, '_blank')}>
                          <ExternalLink className="h-4 w-4" />
                        </Button>
                      )}
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Create Dialog */}
        <Dialog open={showCreateDialog} onOpenChange={setShowCreateDialog}>
          <DialogContent>
            <DialogHeader><DialogTitle>Generar Nueva Factura</DialogTitle></DialogHeader>
            <form onSubmit={(e: any) => {
              e.preventDefault();
              const fd = new FormData(e.target);
              createInvoiceMutation.mutate({
                projectId: parseInt(fd.get('projectId') as string),
                description: fd.get('description'),
                amount: fd.get('amount'),
                dueDate: fd.get('dueDate')
              });
            }} className="space-y-4">
              <div className="space-y-2">
                <Label>Proyecto / Cliente</Label>
                <Select name="projectId" required>
                  <SelectTrigger><SelectValue placeholder="Seleccionar..." /></SelectTrigger>
                  <SelectContent>
                    {projects?.map(p => <SelectItem key={p.id} value={p.id.toString()}>{p.name} - {p.clientName}</SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2"><Label>Monto (USD)</Label><Input name="amount" type="number" step="0.01" required /></div>
              <div className="space-y-2"><Label>Descripción</Label><Input name="description" required /></div>
              <div className="space-y-2"><Label>Vencimiento</Label><Input name="dueDate" type="date" required /></div>
              <Button type="submit" className="w-full" disabled={createInvoiceMutation.isPending}>Crear</Button>
            </form>
          </DialogContent>
        </Dialog>

        {/* Proof Dialog */}
        <Dialog open={showProofDialog} onOpenChange={setShowProofDialog}>
          <DialogContent className="max-w-2xl">
            <DialogHeader><DialogTitle>Verificar Comprobante</DialogTitle></DialogHeader>
            {viewingProof && (
              <div className="space-y-4">
                <div className="aspect-video bg-muted rounded overflow-hidden flex items-center justify-center border">
                  {viewingProof.proofFileUrl?.endsWith('.pdf') ? 
                    <iframe src={`/${viewingProof.proofFileUrl}`} className="w-full h-full" title="PDF Proof" /> :
                    <img src={`/${viewingProof.proofFileUrl}`} className="max-w-full max-h-full object-contain" alt="Proof" />
                  }
                </div>
                <div className="flex justify-between items-center p-4 bg-muted/50 rounded-lg">
                  <div>
                    <div className="font-bold">Gs {parseFloat(viewingProof.totalAmount).toLocaleString()}</div>
                    <div className="text-sm text-muted-foreground">{viewingProof.paymentMethod || 'Método no especificado'}</div>
                  </div>
                  <div className="flex gap-2">
                    <Button variant="outline" onClick={() => setShowProofDialog(false)}>Cerrar</Button>
                    <Button onClick={() => approvePaymentMutation.mutate(viewingProof.id)} disabled={approvePaymentMutation.isPending}>
                      {approvePaymentMutation.isPending ? "Procesando SIFEN..." : "Aprobar y Generar Factura"}
                    </Button>
                  </div>
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>
      </div>
    </DashboardLayout>
  );
}
