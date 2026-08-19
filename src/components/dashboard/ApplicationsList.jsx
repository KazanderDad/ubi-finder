import React from "react";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";
import { Clock, CheckCircle2, XCircle, AlertCircle, PlusCircle } from "lucide-react";
import { Link } from "react-router-dom";

export default function ApplicationsList({ applications = [] }) {
  const getStatusBadge = (status) => {
    switch (status) {
      case "approved":
        return (
          <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-emerald-800 bg-emerald-100 px-2.5 py-0.5 rounded-full border border-emerald-200">
            <CheckCircle2 className="w-3 h-3" /> Approved
          </span>
        );
      case "rejected":
        return (
          <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-red-800 bg-red-100 px-2.5 py-0.5 rounded-full border border-red-200">
            <XCircle className="w-3 h-3" /> Rejected
          </span>
        );
      case "pending":
      case "submitted":
      default:
        return (
          <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-amber-800 bg-amber-100 px-2.5 py-0.5 rounded-full border border-amber-200">
            <Clock className="w-3 h-3" /> Under Review
          </span>
        );
    }
  };

  if (!applications || applications.length === 0) {
    return (
      <div className="text-center py-6 px-4 space-y-3">
        <div className="w-12 h-12 bg-gray-100 text-gray-500 rounded-full flex items-center justify-center mx-auto text-lg">
          📋
        </div>
        <div>
          <h4 className="text-sm font-semibold text-gray-800">No applications tracked yet</h4>
          <p className="text-xs text-gray-500 mt-0.5">
            When you apply to programs, log your submissions here to track your progress and follow-ups.
          </p>
        </div>
        <Link 
          to="/Programs" 
          className="inline-flex items-center gap-1.5 text-xs text-green-700 font-semibold hover:underline"
        >
          <PlusCircle className="w-3.5 h-3.5" />
          Browse Open Programs
        </Link>
      </div>
    );
  }

  return (
    <ScrollArea className="h-[280px] pr-2">
      <div className="space-y-3">
        {applications.map(app => (
          <div 
            key={app.id}
            className="p-3.5 bg-gray-50/80 rounded-xl border border-gray-200/80 flex items-center justify-between hover:bg-gray-100/80 transition-colors"
          >
            <div>
              <h4 className="text-sm font-bold text-green-950">
                {app.program_name || `Program #${app.program_id}`}
              </h4>
              <p className="text-[11px] text-gray-500 mt-0.5">
                Submitted {app.submitted_date ? new Date(app.submitted_date).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' }) : 'recently'}
              </p>
            </div>
            <div>
              {getStatusBadge(app.status)}
            </div>
          </div>
        ))}
      </div>
    </ScrollArea>
  );
}
