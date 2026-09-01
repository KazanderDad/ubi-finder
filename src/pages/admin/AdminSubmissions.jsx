import React, { useState, useEffect } from "react";
import { Link, useNavigate, useSearchParams } from "react-router-dom";
import { supabase } from "@/lib/supabaseClient";
import { useAuth } from "@/lib/AuthContext";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@/components/ui/tabs";
import {
  ShieldCheck,
  CheckCircle2,
  XCircle,
  Clock,
  ExternalLink,
  Edit3,
  Search,
  RefreshCw,
  Eye,
  AlertTriangle,
  FileCheck,
  Building,
  DollarSign,
  MapPin,
  Calendar,
  Users,
  Lock,
  ArrowLeft,
  Filter
} from "lucide-react";
import { Helmet } from "react-helmet-async";

export default function AdminSubmissions() {
  const { user, isAuthenticated, isAdmin, isLoadingAuth } = useAuth();
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const highlightId = searchParams.get("id");

  const [programs, setPrograms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filterTab, setFilterTab] = useState("pending");
  const [searchQuery, setSearchQuery] = useState("");
  const [actionLoading, setActionLoading] = useState(null);

  // Edit dialog state
  const [editingProgram, setEditingProgram] = useState(null);
  const [editFormData, setEditFormData] = useState(/** @type {Record<string, any>} */ ({}));
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);

  // Toast feedback
  const [notification, setNotification] = useState(null);

  const showToast = (message, type = "success") => {
    setNotification({ message, type });
    setTimeout(() => setNotification(null), 4000);
  };

  const fetchSubmissions = async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from("programs")
        .select("*")
        .order("created_at", { ascending: false, nullsFirst: false });

      if (error) {
        console.error("Error fetching submissions:", error);
      } else {
        setPrograms(data || []);
      }
    } catch (err) {
      console.error("fetchSubmissions error:", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (isAuthenticated && isAdmin) {
      fetchSubmissions();
    }
  }, [isAuthenticated, isAdmin]);

  // If user is not authorized
  if (!isLoadingAuth && (!isAuthenticated || !isAdmin)) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center p-4">
        <Helmet>
          <title>Access Restricted | UBI Finder Admin</title>
        </Helmet>
        <Card className="max-w-md w-full border-red-200 shadow-xl">
          <CardHeader className="text-center">
            <div className="mx-auto w-12 h-12 bg-red-100 rounded-full flex items-center justify-center mb-3">
              <Lock className="w-6 h-6 text-red-600" />
            </div>
            <CardTitle className="text-xl font-bold text-gray-900">Admin Access Required</CardTitle>
            <CardDescription className="text-sm text-gray-600">
              This review dashboard is restricted to authorized UBI Finder administrators and owners.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <Button
              onClick={() => navigate("/")}
              className="w-full bg-green-700 hover:bg-green-800 text-white"
            >
              Return to Home
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  // Filter programs based on selected tab and search query
  const filteredPrograms = programs.filter((p) => {
    // Status filter
    const isPending = !p.verified || p.internal_status === "pending_review";
    const isApproved = p.verified && p.internal_status === "active";
    const isRejected = p.internal_status === "rejected" || p.internal_status === "deleted";

    if (filterTab === "pending" && !isPending) return false;
    if (filterTab === "approved" && !isApproved) return false;
    if (filterTab === "rejected" && !isRejected) return false;

    // Search filter
    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase();
      const matchName = p.name?.toLowerCase().includes(q);
      const matchOrg = p.organization?.toLowerCase().includes(q);
      const matchEmail = p.submitter_email?.toLowerCase().includes(q);
      const matchRegion = (p.available_regions || []).some((r) => r.toLowerCase().includes(q));
      return matchName || matchOrg || matchEmail || matchRegion;
    }

    return true;
  });

  const pendingCount = programs.filter((p) => !p.verified || p.internal_status === "pending_review").length;
  const approvedCount = programs.filter((p) => p.verified && p.internal_status === "active").length;
  const rejectedCount = programs.filter((p) => p.internal_status === "rejected" || p.internal_status === "deleted").length;

  // Approve Program
  const handleApprove = async (prog) => {
    try {
      setActionLoading(prog.id);
      const { error } = await supabase
        .from("programs")
        .update({
          verified: true,
          internal_status: "active",
          status: prog.status === "closed" ? "closed" : "active_open",
        })
        .eq("id", prog.id);

      if (error) throw error;

      showToast(`"${prog.name}" has been approved and published!`, "success");
      setPrograms((prev) =>
        prev.map((p) =>
          p.id === prog.id
            ? { ...p, verified: true, internal_status: "active", status: p.status === "closed" ? "closed" : "active_open" }
            : p
        )
      );
    } catch (err) {
      console.error("Error approving program:", err);
      showToast("Failed to approve program. Please try again.", "error");
    } finally {
      setActionLoading(null);
    }
  };

  // Reject / Archive Program
  const handleReject = async (prog) => {
    try {
      setActionLoading(prog.id);
      const { error } = await supabase
        .from("programs")
        .update({
          verified: false,
          internal_status: "rejected",
        })
        .eq("id", prog.id);

      if (error) throw error;

      showToast(`"${prog.name}" marked as rejected.`, "info");
      setPrograms((prev) =>
        prev.map((p) => (p.id === prog.id ? { ...p, verified: false, internal_status: "rejected" } : p))
      );
    } catch (err) {
      console.error("Error rejecting program:", err);
      showToast("Failed to reject program.", "error");
    } finally {
      setActionLoading(null);
    }
  };

  // Open Edit Dialog
  const handleOpenEdit = (prog) => {
    setEditingProgram(prog);
    setEditFormData({
      name: prog.name || "",
      organization: prog.organization || "",
      description: prog.description || "",
      monthly_amount_usd: prog.monthly_amount_usd || "",
      amount_description: prog.amount_description || "",
      currency: prog.currency || "USD",
      available_regions: (prog.available_regions || []).join(", "),
      required_states: (prog.required_states || []).join(", "),
      min_age: prog.min_age !== null && prog.min_age !== undefined ? String(prog.min_age) : "",
      max_age: prog.max_age !== null && prog.max_age !== undefined ? String(prog.max_age) : "",
      gender_requirement: prog.gender_requirement || "none",
      max_household_income_usd: prog.max_household_income_usd || "",
      website: prog.website || "",
      eligibility: prog.eligibility || "",
      verified: prog.verified || false,
    });
    setIsEditDialogOpen(true);
  };

  // Save Edits & Optionally Approve
  const handleSaveEdit = async (autoApprove = false) => {
    if (!editingProgram) return;

    try {
      setActionLoading("edit");
      const regions = editFormData.available_regions
        .split(",")
        .map((r) => r.trim())
        .filter(Boolean);
      const states = editFormData.required_states
        .split(",")
        .map((s) => s.trim())
        .filter(Boolean);

      const updatePayload = {
        name: editFormData.name,
        organization: editFormData.organization,
        description: editFormData.description,
        monthly_amount_usd: editFormData.monthly_amount_usd ? Number(editFormData.monthly_amount_usd) : 0,
        amount_description: editFormData.amount_description,
        currency: editFormData.currency || "USD",
        available_regions: regions.length > 0 ? regions : ["Global"],
        required_states: states,
        min_age: editFormData.min_age ? parseInt(editFormData.min_age, 10) : null,
        max_age: editFormData.max_age ? parseInt(editFormData.max_age, 10) : null,
        gender_requirement: editFormData.gender_requirement === "none" ? null : editFormData.gender_requirement,
        max_household_income_usd: editFormData.max_household_income_usd ? Number(editFormData.max_household_income_usd) : null,
        website: editFormData.website,
        eligibility: editFormData.eligibility,
        verified: autoApprove ? true : editFormData.verified,
        internal_status: autoApprove ? "active" : editingProgram.internal_status,
      };

      const { error } = await supabase
        .from("programs")
        .update(updatePayload)
        .eq("id", editingProgram.id);

      if (error) throw error;

      showToast(
        autoApprove ? `Updated & published "${editFormData.name}"!` : `Saved changes to "${editFormData.name}".`,
        "success"
      );

      setPrograms((prev) =>
        prev.map((p) => (p.id === editingProgram.id ? { ...p, ...updatePayload } : p))
      );
      setIsEditDialogOpen(false);
    } catch (err) {
      console.error("Error saving edits:", err);
      showToast("Failed to save changes.", "error");
    } finally {
      setActionLoading(null);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-green-50/70 via-white to-gray-50 py-10 px-4 sm:px-6 lg:px-8">
      <Helmet>
        <title>Review Submissions | UBI Finder Admin</title>
      </Helmet>

      {/* Floating Notification Toast */}
      {notification && (
        <div
          className={`fixed top-6 right-6 z-50 px-4 py-3 rounded-xl shadow-xl flex items-center gap-2 text-sm font-semibold animate-in slide-in-from-top-2 ${
            notification.type === "success"
              ? "bg-emerald-800 text-white"
              : notification.type === "error"
              ? "bg-rose-800 text-white"
              : "bg-gray-900 text-white"
          }`}
        >
          {notification.type === "success" ? (
            <CheckCircle2 className="w-5 h-5 text-emerald-300" />
          ) : (
            <AlertTriangle className="w-5 h-5 text-amber-300" />
          )}
          <span>{notification.message}</span>
        </div>
      )}

      <div className="max-w-7xl mx-auto space-y-8">
        {/* Top Header */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <Badge className="bg-purple-100 text-purple-800 border-purple-200 uppercase font-bold text-[10px] tracking-wider">
                🛡️ Admin Dashboard
              </Badge>
              <span className="text-xs text-gray-500">•</span>
              <span className="text-xs text-gray-600 font-medium">Logged in as {user?.email}</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-extrabold text-gray-900 tracking-tight flex items-center gap-3">
              <FileCheck className="w-8 h-8 text-green-700" />
              Program Submissions & Moderation
            </h1>
            <p className="text-sm text-gray-600 mt-1">
              Review, edit, and approve community-submitted UBI programs before they appear in public search and matching portfolios.
            </p>
          </div>

          <div className="flex items-center gap-3">
            <Button
              variant="outline"
              size="sm"
              onClick={fetchSubmissions}
              disabled={loading}
              className="border-gray-300 gap-1.5 cursor-pointer bg-white"
            >
              <RefreshCw className={`w-4 h-4 ${loading ? "animate-spin" : ""}`} />
              Refresh
            </Button>
            <Button
              size="sm"
              onClick={() => navigate("/admin/users")}
              className="bg-purple-700 hover:bg-purple-800 text-white gap-1.5 cursor-pointer"
            >
              <Users className="w-4 h-4" />
              Manage Admins
            </Button>
          </div>
        </div>

        {/* Metrics Overview Cards */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <Card
            onClick={() => setFilterTab("pending")}
            className={`cursor-pointer transition-all border ${
              filterTab === "pending"
                ? "ring-2 ring-amber-500 bg-amber-50/50 border-amber-300 shadow-sm"
                : "hover:border-amber-200 bg-white"
            }`}
          >
            <CardContent className="p-5 flex items-center justify-between">
              <div>
                <p className="text-xs uppercase font-bold tracking-wider text-amber-700">Pending Review</p>
                <h3 className="text-2xl font-black text-gray-900 mt-1">{pendingCount}</h3>
                <p className="text-xs text-gray-500 mt-0.5">Awaiting verification</p>
              </div>
              <div className="w-12 h-12 rounded-2xl bg-amber-100 flex items-center justify-center text-amber-700">
                <Clock className="w-6 h-6" />
              </div>
            </CardContent>
          </Card>

          <Card
            onClick={() => setFilterTab("approved")}
            className={`cursor-pointer transition-all border ${
              filterTab === "approved"
                ? "ring-2 ring-emerald-500 bg-emerald-50/50 border-emerald-300 shadow-sm"
                : "hover:border-emerald-200 bg-white"
            }`}
          >
            <CardContent className="p-5 flex items-center justify-between">
              <div>
                <p className="text-xs uppercase font-bold tracking-wider text-emerald-700">Live & Published</p>
                <h3 className="text-2xl font-black text-gray-900 mt-1">{approvedCount}</h3>
                <p className="text-xs text-gray-500 mt-0.5">Active in public directory</p>
              </div>
              <div className="w-12 h-12 rounded-2xl bg-emerald-100 flex items-center justify-center text-emerald-700">
                <CheckCircle2 className="w-6 h-6" />
              </div>
            </CardContent>
          </Card>

          <Card
            onClick={() => setFilterTab("rejected")}
            className={`cursor-pointer transition-all border ${
              filterTab === "rejected"
                ? "ring-2 ring-rose-500 bg-rose-50/50 border-rose-300 shadow-sm"
                : "hover:border-rose-200 bg-white"
            }`}
          >
            <CardContent className="p-5 flex items-center justify-between">
              <div>
                <p className="text-xs uppercase font-bold tracking-wider text-rose-700">Rejected / Inactive</p>
                <h3 className="text-2xl font-black text-gray-900 mt-1">{rejectedCount}</h3>
                <p className="text-xs text-gray-500 mt-0.5">Hidden from catalog</p>
              </div>
              <div className="w-12 h-12 rounded-2xl bg-rose-100 flex items-center justify-center text-rose-700">
                <XCircle className="w-6 h-6" />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Filter Bar & Search */}
        <div className="flex flex-col sm:flex-row gap-4 items-center justify-between bg-white p-4 rounded-2xl border border-gray-200 shadow-xs">
          <Tabs value={filterTab} onValueChange={setFilterTab} className="w-full sm:w-auto">
            <TabsList className="bg-gray-100 p-1">
              <TabsTrigger value="pending" className="text-xs font-semibold gap-1.5">
                <Clock className="w-3.5 h-3.5" />
                Pending ({pendingCount})
              </TabsTrigger>
              <TabsTrigger value="approved" className="text-xs font-semibold gap-1.5">
                <CheckCircle2 className="w-3.5 h-3.5" />
                Published ({approvedCount})
              </TabsTrigger>
              <TabsTrigger value="rejected" className="text-xs font-semibold gap-1.5">
                <XCircle className="w-3.5 h-3.5" />
                Rejected ({rejectedCount})
              </TabsTrigger>
              <TabsTrigger value="all" className="text-xs font-semibold">
                All ({programs.length})
              </TabsTrigger>
            </TabsList>
          </Tabs>

          <div className="relative w-full sm:w-72">
            <Search className="w-4 h-4 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" />
            <Input
              type="text"
              placeholder="Search submissions..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-9 text-xs h-9 bg-gray-50/50"
            />
          </div>
        </div>

        {/* Submissions List */}
        {loading ? (
          <div className="p-12 text-center bg-white rounded-2xl border border-gray-200">
            <RefreshCw className="w-8 h-8 text-green-700 animate-spin mx-auto mb-3" />
            <p className="text-sm font-semibold text-gray-700">Loading submissions...</p>
          </div>
        ) : filteredPrograms.length === 0 ? (
          <div className="p-12 text-center bg-white rounded-2xl border border-dashed border-gray-300">
            <FileCheck className="w-12 h-12 text-gray-300 mx-auto mb-3" />
            <h3 className="text-base font-bold text-gray-900">No submissions found</h3>
            <p className="text-xs text-gray-500 mt-1 max-w-sm mx-auto">
              {filterTab === "pending"
                ? "No pending submissions currently waiting for review."
                : "No programs match your current filter and search query."}
            </p>
          </div>
        ) : (
          <div className="space-y-4">
            {filteredPrograms.map((prog) => {
              const isPending = !prog.verified || prog.internal_status === "pending_review";
              const isHighlighted = highlightId && String(prog.program_id) === highlightId;

              return (
                <Card
                  key={prog.id}
                  className={`overflow-hidden border transition-all ${
                    isHighlighted
                      ? "ring-2 ring-green-600 shadow-lg bg-green-50/20"
                      : isPending
                      ? "border-amber-200 shadow-xs bg-white"
                      : "border-gray-200 bg-white"
                  }`}
                >
                  <CardHeader className="pb-3 border-b border-gray-100 bg-gray-50/40">
                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
                      <div className="flex items-center gap-2.5 flex-wrap">
                        <h2 className="text-lg font-bold text-gray-900 leading-tight">
                          {prog.name}
                        </h2>
                        {isPending ? (
                          <Badge className="bg-amber-100 text-amber-800 border-amber-300 gap-1 font-bold text-[11px]">
                            <Clock className="w-3 h-3" />
                            Pending Approval
                          </Badge>
                        ) : prog.verified ? (
                          <Badge className="bg-emerald-100 text-emerald-800 border-emerald-300 gap-1 font-bold text-[11px]">
                            <CheckCircle2 className="w-3 h-3" />
                            Verified & Live
                          </Badge>
                        ) : (
                          <Badge className="bg-rose-100 text-rose-800 border-rose-300 gap-1 font-bold text-[11px]">
                            <XCircle className="w-3 h-3" />
                            Rejected / Inactive
                          </Badge>
                        )}
                        {prog.program_id && (
                          <span className="text-[11px] text-gray-400 font-mono">
                            ID: #{prog.program_id}
                          </span>
                        )}
                      </div>

                      <div className="text-xs text-gray-500 flex items-center gap-1.5">
                        <Building className="w-3.5 h-3.5 text-gray-400" />
                        <span className="font-semibold text-gray-700">{prog.organization || "Independent Organization"}</span>
                      </div>
                    </div>
                  </CardHeader>

                  <CardContent className="p-5 space-y-4">
                    {/* Key Attributes Grid */}
                    <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-3 bg-gray-50 p-3.5 rounded-xl border border-gray-100 text-xs">
                      <div>
                        <span className="text-[10px] uppercase font-bold text-gray-400 block mb-0.5">
                          Disbursement Amount
                        </span>
                        <span className="font-semibold text-gray-900 flex items-center gap-1">
                          <DollarSign className="w-3.5 h-3.5 text-green-700" />
                          {prog.amount_description || `$${prog.monthly_amount_usd || 0} / month`}
                        </span>
                      </div>

                      <div>
                        <span className="text-[10px] uppercase font-bold text-gray-400 block mb-0.5">
                          Geographic Scope
                        </span>
                        <span className="font-semibold text-gray-900 flex items-center gap-1 truncate">
                          <MapPin className="w-3.5 h-3.5 text-green-700 flex-shrink-0" />
                          {prog.available_regions && prog.available_regions.length > 0
                            ? prog.available_regions.join(", ")
                            : "Global / Worldwide"}
                        </span>
                      </div>

                      <div>
                        <span className="text-[10px] uppercase font-bold text-gray-400 block mb-0.5">
                          Age Criteria
                        </span>
                        <span className="font-semibold text-gray-900 flex items-center gap-1">
                          <Calendar className="w-3.5 h-3.5 text-green-700" />
                          {prog.min_age && prog.max_age
                            ? `${prog.min_age} - ${prog.max_age} yrs`
                            : prog.min_age
                            ? `${prog.min_age}+ yrs`
                            : prog.max_age
                            ? `< ${prog.max_age} yrs`
                            : "Universal (All ages)"}
                        </span>
                      </div>

                      <div>
                        <span className="text-[10px] uppercase font-bold text-gray-400 block mb-0.5">
                          Submitter Contact
                        </span>
                        <span className="font-semibold text-gray-900 truncate block">
                          {prog.submitter_email || "System / Seed"}
                        </span>
                      </div>
                    </div>

                    {/* Description & Eligibility Preview */}
                    <div className="space-y-2">
                      <p className="text-xs text-gray-700 leading-relaxed line-clamp-2">
                        {prog.description || "No description provided."}
                      </p>

                      {prog.eligibility && (
                        <div className="text-[11px] text-gray-600 bg-amber-50/50 p-2.5 rounded-lg border border-amber-100">
                          <span className="font-bold text-amber-900 mr-1">Eligibility Notes:</span>
                          <span className="whitespace-pre-line">{prog.eligibility}</span>
                        </div>
                      )}
                    </div>

                    {/* Sources & Links */}
                    {prog.website && (
                      <div className="flex items-center gap-2 text-xs">
                        <span className="text-gray-400">Official Link:</span>
                        <a
                          href={prog.website}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-green-700 hover:underline inline-flex items-center gap-1 font-medium truncate max-w-md"
                        >
                          {prog.website}
                          <ExternalLink className="w-3 h-3" />
                        </a>
                      </div>
                    )}

                    {/* Action Buttons */}
                    <div className="pt-2 border-t border-gray-100 flex flex-wrap items-center justify-between gap-3">
                      <div className="flex items-center gap-2">
                        <Link
                          to={`/program-details?id=${prog.program_id || prog.id}`}
                          target="_blank"
                          className="inline-flex items-center gap-1 text-xs text-gray-600 hover:text-green-700 font-medium py-1.5 px-3 rounded-lg hover:bg-gray-100 transition-colors"
                        >
                          <Eye className="w-3.5 h-3.5" />
                          View Public Page
                        </Link>
                        <Button
                          variant="outline"
                          size="sm"
                          onClick={() => handleOpenEdit(prog)}
                          className="h-8 text-xs gap-1 cursor-pointer border-gray-300"
                        >
                          <Edit3 className="w-3.5 h-3.5" />
                          Edit Details
                        </Button>
                      </div>

                      <div className="flex items-center gap-2">
                        {isPending ? (
                          <>
                            <Button
                              variant="outline"
                              size="sm"
                              disabled={actionLoading === prog.id}
                              onClick={() => handleReject(prog)}
                              className="h-8 text-xs text-rose-700 hover:text-rose-800 hover:bg-rose-50 border-rose-200 cursor-pointer"
                            >
                              <XCircle className="w-3.5 h-3.5 mr-1" />
                              Reject
                            </Button>
                            <Button
                              size="sm"
                              disabled={actionLoading === prog.id}
                              onClick={() => handleApprove(prog)}
                              className="h-8 text-xs bg-emerald-700 hover:bg-emerald-800 text-white font-bold gap-1 cursor-pointer shadow-xs"
                            >
                              <CheckCircle2 className="w-4 h-4" />
                              Approve & Publish
                            </Button>
                          </>
                        ) : prog.verified ? (
                          <Button
                            variant="outline"
                            size="sm"
                            disabled={actionLoading === prog.id}
                            onClick={() => handleReject(prog)}
                            className="h-8 text-xs text-rose-700 hover:bg-rose-50 border-rose-200 cursor-pointer"
                          >
                            Unpublish / Archive
                          </Button>
                        ) : (
                          <Button
                            size="sm"
                            disabled={actionLoading === prog.id}
                            onClick={() => handleApprove(prog)}
                            className="h-8 text-xs bg-emerald-700 hover:bg-emerald-800 text-white font-bold gap-1 cursor-pointer"
                          >
                            <CheckCircle2 className="w-4 h-4" />
                            Re-Approve & Publish
                          </Button>
                        )}
                      </div>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        )}
      </div>

      {/* Edit Program Dialog */}
      <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
        <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="text-lg font-bold text-gray-900">
              Edit Program Submission
            </DialogTitle>
            <DialogDescription className="text-xs text-gray-600">
              Modify program metadata, eligibility limits, or payment terms before approving.
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4 py-2">
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <Label className="text-xs font-semibold">Program Name</Label>
                <Input
                  value={editFormData.name || ""}
                  onChange={(e) => setEditFormData({ ...editFormData, name: e.target.value })}
                  className="mt-1 text-xs"
                />
              </div>
              <div>
                <Label className="text-xs font-semibold">Organization</Label>
                <Input
                  value={editFormData.organization || ""}
                  onChange={(e) => setEditFormData({ ...editFormData, organization: e.target.value })}
                  className="mt-1 text-xs"
                />
              </div>
            </div>

            <div>
              <Label className="text-xs font-semibold">Description</Label>
              <Textarea
                value={editFormData.description || ""}
                onChange={(e) => setEditFormData({ ...editFormData, description: e.target.value })}
                className="mt-1 text-xs h-20"
              />
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
              <div>
                <Label className="text-xs font-semibold">Monthly Amount (USD)</Label>
                <Input
                  type="number"
                  value={editFormData.monthly_amount_usd || ""}
                  onChange={(e) => setEditFormData({ ...editFormData, monthly_amount_usd: e.target.value })}
                  className="mt-1 text-xs"
                />
              </div>
              <div className="sm:col-span-2">
                <Label className="text-xs font-semibold">Payout Description</Label>
                <Input
                  value={editFormData.amount_description || ""}
                  onChange={(e) => setEditFormData({ ...editFormData, amount_description: e.target.value })}
                  placeholder="e.g. $500/mo for 12 months"
                  className="mt-1 text-xs"
                />
              </div>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <div>
                <Label className="text-xs font-semibold">Available Regions (comma separated)</Label>
                <Input
                  value={editFormData.available_regions || ""}
                  onChange={(e) => setEditFormData({ ...editFormData, available_regions: e.target.value })}
                  placeholder="e.g. United States, Canada, Global"
                  className="mt-1 text-xs"
                />
              </div>
              <div>
                <Label className="text-xs font-semibold">Required States/Provinces (optional)</Label>
                <Input
                  value={editFormData.required_states || ""}
                  onChange={(e) => setEditFormData({ ...editFormData, required_states: e.target.value })}
                  placeholder="e.g. Illinois, California"
                  className="mt-1 text-xs"
                />
              </div>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
              <div>
                <Label className="text-xs font-semibold">Min Age (optional)</Label>
                <Input
                  type="number"
                  value={editFormData.min_age || ""}
                  onChange={(e) => setEditFormData({ ...editFormData, min_age: e.target.value })}
                  placeholder="e.g. 18"
                  className="mt-1 text-xs"
                />
              </div>
              <div>
                <Label className="text-xs font-semibold">Max Age (optional)</Label>
                <Input
                  type="number"
                  value={editFormData.max_age || ""}
                  onChange={(e) => setEditFormData({ ...editFormData, max_age: e.target.value })}
                  placeholder="e.g. 29"
                  className="mt-1 text-xs"
                />
              </div>
              <div>
                <Label className="text-xs font-semibold">Gender Requirement</Label>
                <Select
                  value={editFormData.gender_requirement || "none"}
                  onValueChange={(v) => setEditFormData({ ...editFormData, gender_requirement: v })}
                >
                  <SelectTrigger className="mt-1 text-xs bg-white">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="none">Open to all (None)</SelectItem>
                    <SelectItem value="female">Female only</SelectItem>
                    <SelectItem value="male">Male only</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div>
              <Label className="text-xs font-semibold">Official Website URL</Label>
              <Input
                value={editFormData.website || ""}
                onChange={(e) => setEditFormData({ ...editFormData, website: e.target.value })}
                placeholder="https://..."
                className="mt-1 text-xs"
              />
            </div>

            <div>
              <Label className="text-xs font-semibold">Detailed Eligibility Text</Label>
              <Textarea
                value={editFormData.eligibility || ""}
                onChange={(e) => setEditFormData({ ...editFormData, eligibility: e.target.value })}
                className="mt-1 text-xs h-20"
              />
            </div>
          </div>

          <DialogFooter className="flex flex-row items-center justify-between gap-2 pt-3 border-t">
            <Button
              variant="outline"
              size="sm"
              onClick={() => setIsEditDialogOpen(false)}
              className="text-xs"
            >
              Cancel
            </Button>
            <div className="flex gap-2">
              <Button
                variant="outline"
                size="sm"
                disabled={actionLoading === "edit"}
                onClick={() => handleSaveEdit(false)}
                className="text-xs border-green-600 text-green-700 hover:bg-green-50 cursor-pointer"
              >
                Save Draft
              </Button>
              <Button
                size="sm"
                disabled={actionLoading === "edit"}
                onClick={() => handleSaveEdit(true)}
                className="text-xs bg-emerald-700 hover:bg-emerald-800 text-white font-bold cursor-pointer"
              >
                Save & Approve Now
              </Button>
            </div>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
