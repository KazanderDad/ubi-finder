import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/lib/supabaseClient";
import { useAuth } from "@/lib/AuthContext";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
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
  Tabs,
  TabsList,
  TabsTrigger,
} from "@/components/ui/tabs";
import {
  ShieldCheck,
  Crown,
  UserCheck,
  UserX,
  User,
  Search,
  RefreshCw,
  Lock,
  AlertTriangle,
  CheckCircle2,
  FileCheck,
  Shield,
  ArrowLeft,
  Mail
} from "lucide-react";
import { Helmet } from "react-helmet-async";

export default function AdminUsers() {
  const { user: currentUser, isAuthenticated, isAdmin, isOwner, isLoadingAuth } = useAuth();
  const navigate = useNavigate();

  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [filterTab, setFilterTab] = useState("all");
  const [searchQuery, setSearchQuery] = useState("");
  const [actionLoading, setActionLoading] = useState(null);

  // Confirmation dialog state
  const [confirmDialog, setConfirmDialog] = useState({
    isOpen: false,
    targetUser: null,
    newRole: null,
    title: "",
    description: "",
  });

  // Notification Toast
  const [notification, setNotification] = useState(null);

  const showToast = (message, type = "success") => {
    setNotification({ message, type });
    setTimeout(() => setNotification(null), 4000);
  };

  const fetchUsers = async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from("users")
        .select("id, email, full_name, role, created_date, updated_date")
        .order("created_date", { ascending: false });

      if (error) {
        console.error("Error fetching users:", error);
      } else {
        setUsers(data || []);
      }
    } catch (err) {
      console.error("fetchUsers error:", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (isAuthenticated && isAdmin) {
      fetchUsers();
    }
  }, [isAuthenticated, isAdmin]);

  // Authorization check
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
              Only platform administrators and owners can view and manage user permissions.
            </CardDescription>
          </CardHeader>
          <CardContent>
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

  // Role Action Confirmation Trigger
  const promptRoleChange = (targetUser, newRole) => {
    if (targetUser.role === "owner" && newRole !== "owner") {
      showToast("Cannot modify or remove an Owner.", "error");
      return;
    }

    if (newRole === "admin") {
      setConfirmDialog({
        isOpen: true,
        targetUser,
        newRole: "admin",
        title: `Elevate ${targetUser.full_name || targetUser.email} to Admin?`,
        description: `This will grant ${targetUser.email} full administrator privileges to review and publish submissions and view platform analytics.`,
      });
    } else if (newRole === "user") {
      setConfirmDialog({
        isOpen: true,
        targetUser,
        newRole: "user",
        title: `Demote ${targetUser.full_name || targetUser.email} to Regular User?`,
        description: `This will revoke administrator rights from ${targetUser.email}. They will no longer have access to the moderation portal.`,
      });
    }
  };

  // Execute Role Change via RPC or direct update with trigger safety
  const executeRoleChange = async () => {
    const { targetUser, newRole } = confirmDialog;
    if (!targetUser || !newRole) return;

    try {
      setActionLoading(targetUser.id);
      setConfirmDialog({ ...confirmDialog, isOpen: false });

      // First try via security definer RPC set_user_role
      let updateError = null;
      try {
        const { error } = await supabase.rpc("set_user_role", {
          target_user_id: targetUser.id,
          new_role: newRole,
        });
        if (error) updateError = error;
      } catch (rpcErr) {
        updateError = rpcErr;
      }

      // Fallback to direct update if RPC is not available yet
      if (updateError) {
        const { error: directErr } = await supabase
          .from("users")
          .update({ role: newRole })
          .eq("id", targetUser.id);
        if (directErr) throw directErr;
      }

      showToast(
        newRole === "admin"
          ? `Elevated ${targetUser.full_name || targetUser.email} to Administrator!`
          : `Removed admin rights from ${targetUser.full_name || targetUser.email}.`,
        "success"
      );

      setUsers((prev) =>
        prev.map((u) => (u.id === targetUser.id ? { ...u, role: newRole } : u))
      );
    } catch (err) {
      console.error("Error executing role change:", err);
      showToast(err.message || "Failed to update role. Owners cannot be demoted.", "error");
    } finally {
      setActionLoading(null);
    }
  };

  // Counts
  const ownerCount = users.filter((u) => u.role === "owner").length;
  const adminCount = users.filter((u) => u.role === "admin").length;
  const regularCount = users.filter((u) => u.role === "user" || !u.role).length;

  // Filtered Users
  const filteredUsers = users.filter((u) => {
    if (filterTab === "owners" && u.role !== "owner") return false;
    if (filterTab === "admins" && u.role !== "admin") return false;
    if (filterTab === "users" && u.role !== "user" && u.role) return false;

    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase();
      const matchName = u.full_name?.toLowerCase().includes(q);
      const matchEmail = u.email?.toLowerCase().includes(q);
      return matchName || matchEmail;
    }
    return true;
  });

  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-50/50 via-white to-gray-50 py-10 px-4 sm:px-6 lg:px-8">
      <Helmet>
        <title>Manage Administrators | UBI Finder Admin</title>
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
        {/* Header */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <div className="flex items-center gap-2 mb-1">
              <Badge className="bg-purple-100 text-purple-800 border-purple-200 uppercase font-bold text-[10px] tracking-wider">
                🛡️ Permissions & Security
              </Badge>
              <span className="text-xs text-gray-500">•</span>
              <span className="text-xs text-gray-600 font-medium">Logged in as {currentUser?.email}</span>
            </div>
            <h1 className="text-2xl sm:text-3xl font-extrabold text-gray-900 tracking-tight flex items-center gap-3">
              <ShieldCheck className="w-8 h-8 text-purple-700" />
              Administrator & User Role Management
            </h1>
            <p className="text-sm text-gray-600 mt-1">
              View platform members, elevate trustworthy contributors to administrators, and monitor role permissions.
            </p>
          </div>

          <div className="flex items-center gap-3">
            <Button
              variant="outline"
              size="sm"
              onClick={fetchUsers}
              disabled={loading}
              className="border-gray-300 gap-1.5 cursor-pointer bg-white"
            >
              <RefreshCw className={`w-4 h-4 ${loading ? "animate-spin" : ""}`} />
              Refresh
            </Button>
            <Button
              size="sm"
              onClick={() => navigate("/admin/submissions")}
              className="bg-green-700 hover:bg-green-800 text-white gap-1.5 cursor-pointer"
            >
              <FileCheck className="w-4 h-4" />
              Review Submissions
            </Button>
          </div>
        </div>

        {/* Role Statistics Cards */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <Card
            onClick={() => setFilterTab("owners")}
            className={`cursor-pointer transition-all border ${
              filterTab === "owners"
                ? "ring-2 ring-amber-500 bg-amber-50/50 border-amber-300 shadow-sm"
                : "hover:border-amber-200 bg-white"
            }`}
          >
            <CardContent className="p-5 flex items-center justify-between">
              <div>
                <p className="text-xs uppercase font-bold tracking-wider text-amber-700">Protected Owners</p>
                <h3 className="text-2xl font-black text-gray-900 mt-1">{ownerCount}</h3>
                <p className="text-xs text-gray-500 mt-0.5">Permanent system authority</p>
              </div>
              <div className="w-12 h-12 rounded-2xl bg-amber-100 flex items-center justify-center text-amber-700">
                <Crown className="w-6 h-6" />
              </div>
            </CardContent>
          </Card>

          <Card
            onClick={() => setFilterTab("admins")}
            className={`cursor-pointer transition-all border ${
              filterTab === "admins"
                ? "ring-2 ring-purple-500 bg-purple-50/50 border-purple-300 shadow-sm"
                : "hover:border-purple-200 bg-white"
            }`}
          >
            <CardContent className="p-5 flex items-center justify-between">
              <div>
                <p className="text-xs uppercase font-bold tracking-wider text-purple-700">Active Admins</p>
                <h3 className="text-2xl font-black text-gray-900 mt-1">{adminCount}</h3>
                <p className="text-xs text-gray-500 mt-0.5">Moderators & reviewers</p>
              </div>
              <div className="w-12 h-12 rounded-2xl bg-purple-100 flex items-center justify-center text-purple-700">
                <Shield className="w-6 h-6" />
              </div>
            </CardContent>
          </Card>

          <Card
            onClick={() => setFilterTab("users")}
            className={`cursor-pointer transition-all border ${
              filterTab === "users"
                ? "ring-2 ring-gray-400 bg-gray-50 border-gray-300 shadow-sm"
                : "hover:border-gray-300 bg-white"
            }`}
          >
            <CardContent className="p-5 flex items-center justify-between">
              <div>
                <p className="text-xs uppercase font-bold tracking-wider text-gray-600">Registered Members</p>
                <h3 className="text-2xl font-black text-gray-900 mt-1">{regularCount}</h3>
                <p className="text-xs text-gray-500 mt-0.5">Standard user accounts</p>
              </div>
              <div className="w-12 h-12 rounded-2xl bg-gray-100 flex items-center justify-center text-gray-600">
                <User className="w-6 h-6" />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Filter Bar & Search */}
        <div className="flex flex-col sm:flex-row gap-4 items-center justify-between bg-white p-4 rounded-2xl border border-gray-200 shadow-xs">
          <Tabs value={filterTab} onValueChange={setFilterTab} className="w-full sm:w-auto">
            <TabsList className="bg-gray-100 p-1">
              <TabsTrigger value="all" className="text-xs font-semibold">
                All Members ({users.length})
              </TabsTrigger>
              <TabsTrigger value="owners" className="text-xs font-semibold gap-1">
                <Crown className="w-3.5 h-3.5 text-amber-600" />
                Owners ({ownerCount})
              </TabsTrigger>
              <TabsTrigger value="admins" className="text-xs font-semibold gap-1">
                <Shield className="w-3.5 h-3.5 text-purple-600" />
                Admins ({adminCount})
              </TabsTrigger>
              <TabsTrigger value="users" className="text-xs font-semibold">
                Users ({regularCount})
              </TabsTrigger>
            </TabsList>
          </Tabs>

          <div className="relative w-full sm:w-72">
            <Search className="w-4 h-4 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" />
            <Input
              type="text"
              placeholder="Search by name or email..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="pl-9 text-xs h-9 bg-gray-50/50"
            />
          </div>
        </div>

        {/* User Table Card */}
        <Card className="shadow-xs border border-gray-200 overflow-hidden bg-white">
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse">
              <thead>
                <tr className="bg-gray-50/80 border-b border-gray-200 text-[11px] uppercase tracking-wider text-gray-500 font-bold">
                  <th className="py-3.5 px-5">User</th>
                  <th className="py-3.5 px-5">Email Address</th>
                  <th className="py-3.5 px-5">Current Role</th>
                  <th className="py-3.5 px-5">Joined</th>
                  <th className="py-3.5 px-5 text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100 text-xs">
                {loading ? (
                  <tr>
                    <td colSpan={5} className="py-12 text-center text-gray-500">
                      <RefreshCw className="w-6 h-6 text-purple-700 animate-spin mx-auto mb-2" />
                      Loading user accounts...
                    </td>
                  </tr>
                ) : filteredUsers.length === 0 ? (
                  <tr>
                    <td colSpan={5} className="py-12 text-center text-gray-500">
                      No user accounts found matching your query.
                    </td>
                  </tr>
                ) : (
                  filteredUsers.map((u) => {
                    const isSelf = currentUser?.id === u.id || currentUser?.email === u.email;
                    const isTargetOwner = u.role === "owner";
                    const isTargetAdmin = u.role === "admin";

                    return (
                      <tr key={u.id} className="hover:bg-gray-50/60 transition-colors">
                        <td className="py-3.5 px-5">
                          <div className="flex items-center gap-3">
                            <div
                              className={`w-8 h-8 rounded-full flex items-center justify-center font-bold text-xs ${
                                isTargetOwner
                                  ? "bg-amber-100 text-amber-800"
                                  : isTargetAdmin
                                  ? "bg-purple-100 text-purple-800"
                                  : "bg-gray-100 text-gray-700"
                              }`}
                            >
                              {(u.full_name || u.email || "U").charAt(0).toUpperCase()}
                            </div>
                            <div>
                              <span className="font-bold text-gray-900 block">
                                {u.full_name || "Community Member"}
                              </span>
                              {isSelf && (
                                <span className="text-[10px] text-green-700 font-semibold bg-green-50 px-1.5 py-0.2 rounded">
                                  You
                                </span>
                              )}
                            </div>
                          </div>
                        </td>

                        <td className="py-3.5 px-5 font-mono text-gray-700">
                          <div className="flex items-center gap-1.5">
                            <Mail className="w-3.5 h-3.5 text-gray-400" />
                            {u.email}
                          </div>
                        </td>

                        <td className="py-3.5 px-5">
                          {isTargetOwner ? (
                            <Badge className="bg-amber-100 text-amber-900 border-amber-300 gap-1 font-bold text-[11px] shadow-xs">
                              <Crown className="w-3 h-3 text-amber-600" />
                              Owner
                            </Badge>
                          ) : isTargetAdmin ? (
                            <Badge className="bg-purple-100 text-purple-900 border-purple-300 gap-1 font-bold text-[11px] shadow-xs">
                              <Shield className="w-3 h-3 text-purple-600" />
                              Admin
                            </Badge>
                          ) : (
                            <Badge variant="outline" className="text-gray-600 border-gray-300 gap-1 font-normal text-[11px]">
                              <User className="w-3 h-3 text-gray-400" />
                              User
                            </Badge>
                          )}
                        </td>

                        <td className="py-3.5 px-5 text-gray-500">
                          {u.created_date
                            ? new Date(u.created_date).toLocaleDateString(undefined, {
                                year: "numeric",
                                month: "short",
                                day: "numeric",
                              })
                            : "—"}
                        </td>

                        <td className="py-3.5 px-5 text-right">
                          {isTargetOwner ? (
                            <span
                              title="Owner accounts cannot be modified or demoted by administrators."
                              className="inline-flex items-center gap-1 text-[11px] text-amber-700 bg-amber-50 px-2.5 py-1 rounded-md border border-amber-200 font-medium cursor-not-allowed select-none"
                            >
                              <Lock className="w-3 h-3" />
                              Protected Owner
                            </span>
                          ) : isTargetAdmin ? (
                            <Button
                              variant="outline"
                              size="sm"
                              disabled={actionLoading === u.id}
                              onClick={() => promptRoleChange(u, "user")}
                              className="h-7 text-xs text-rose-700 hover:text-rose-800 hover:bg-rose-50 border-rose-200 cursor-pointer"
                            >
                              <UserX className="w-3 h-3 mr-1" />
                              Demote to User
                            </Button>
                          ) : (
                            <Button
                              size="sm"
                              disabled={actionLoading === u.id}
                              onClick={() => promptRoleChange(u, "admin")}
                              className="h-7 text-xs bg-purple-700 hover:bg-purple-800 text-white font-bold cursor-pointer"
                            >
                              <UserCheck className="w-3 h-3 mr-1" />
                              Elevate to Admin
                            </Button>
                          )}
                        </td>
                      </tr>
                    );
                  })
                )}
              </tbody>
            </table>
          </div>
        </Card>
      </div>

      {/* Confirmation Dialog */}
      <Dialog open={confirmDialog.isOpen} onOpenChange={(open) => setConfirmDialog({ ...confirmDialog, isOpen: open })}>
        <DialogContent className="max-w-md">
          <DialogHeader>
            <DialogTitle className="text-base font-bold text-gray-900">
              {confirmDialog.title}
            </DialogTitle>
            <DialogDescription className="text-xs text-gray-600 mt-2 leading-relaxed">
              {confirmDialog.description}
            </DialogDescription>
          </DialogHeader>

          <DialogFooter className="flex flex-row items-center justify-end gap-2 pt-3 border-t">
            <Button
              variant="outline"
              size="sm"
              onClick={() => setConfirmDialog({ ...confirmDialog, isOpen: false })}
              className="text-xs"
            >
              Cancel
            </Button>
            <Button
              size="sm"
              disabled={actionLoading !== null}
              onClick={executeRoleChange}
              className={`text-xs font-bold text-white ${
                confirmDialog.newRole === "admin"
                  ? "bg-purple-700 hover:bg-purple-800"
                  : "bg-rose-700 hover:bg-rose-800"
              }`}
            >
              {confirmDialog.newRole === "admin" ? "Confirm Elevation" : "Confirm Demotion"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
