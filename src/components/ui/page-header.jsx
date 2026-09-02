import React from "react";
import { Leaf } from "lucide-react";

export default function PageHeader({ 
  icon: Icon = Leaf, 
  badgeText = null,
  title, 
  subtitle, 
  className = "" 
}) {
  return (
    <div className={`text-center max-w-3xl mx-auto mb-10 ${className}`}>
      {Icon && (
        <div className="inline-flex items-center justify-center p-2.5 bg-green-100/90 rounded-full mb-3.5 shadow-inner border border-green-200">
          <Icon className="w-6 h-6 text-green-700" />
        </div>
      )}
      {badgeText && (
        <div className="block mb-2">
          <span className="text-[11px] font-bold uppercase tracking-wider text-green-700 bg-green-100/70 px-2.5 py-0.5 rounded-full border border-green-200">
            {badgeText}
          </span>
        </div>
      )}
      <h1 className="text-3xl md:text-4xl font-extrabold text-green-950 tracking-tight">
        {title}
      </h1>
      {subtitle && (
        <p className="text-sm md:text-base text-gray-600 mt-2.5 leading-relaxed max-w-2xl mx-auto">
          {subtitle}
        </p>
      )}
    </div>
  );
}
