import React from "react";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Badge } from "@/components/ui/badge";

export default function ApplicationsList({ applications = [] }) {
  const getStatusColor = (status) => {
    switch (status) {
      case "pending":
        return "bg-yellow-100 text-yellow-800";
      case "approved":
        return "bg-green-100 text-green-800";
      case "rejected":
        return "bg-red-100 text-red-800";
      default:
        return "bg-gray-100 text-gray-800";
    }
  };

  return (
    <ScrollArea className="h-[250px]">
      {applications.map(app => (
        <div 
          key={app.id}
          className="p-4 border-b last:border-0 hover:bg-green-50"
        >
          <div className="flex justify-between items-start">
            <div>
              <h3 className="font-medium text-green-900">{app.program_id}</h3>
              <p className="text-sm text-green-700">
                Submitted: {new Date(app.submitted_date).toLocaleDateString()}
              </p>
            </div>
            <Badge className={getStatusColor(app.status)}>
              {app.status.charAt(0).toUpperCase() + app.status.slice(1)}
            </Badge>
          </div>
        </div>
      ))}
    </ScrollArea>
  );
}

