import React, { useState } from "react";
import { AlertCircle, ChevronUp, ChevronDown, Mail, X } from "lucide-react";

export default function PrototypeDisclaimer() {
  const [isExpanded, setIsExpanded] = useState(false);

  return (
    <aside 
      aria-label="Prototype Site Disclaimer"
      className="fixed bottom-4 right-4 z-50 select-none print:hidden pointer-events-auto transition-all duration-300 ease-in-out"
    >
      {!isExpanded ? (
        <button
          type="button"
          onClick={() => setIsExpanded(true)}
          className="group flex items-center gap-2 px-3 py-1.5 bg-slate-900/90 hover:bg-slate-900 text-slate-200 hover:text-white rounded-full shadow-lg border border-slate-700/80 backdrop-blur-md text-xs font-medium cursor-pointer transition-all hover:scale-105 active:scale-95"
          title="Click to view disclaimer"
        >
          <span className="relative flex h-2 w-2">
            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-amber-400 opacity-75"></span>
            <span className="relative inline-flex rounded-full h-2 w-2 bg-amber-500"></span>
          </span>
          <span>Prototype site.</span>
          <ChevronUp className="w-3.5 h-3.5 text-slate-400 group-hover:text-white transition-transform" />
        </button>
      ) : (
        <div className="bg-slate-900/95 text-slate-100 border border-slate-700 rounded-2xl p-4 shadow-2xl backdrop-blur-md max-w-xs sm:max-w-sm text-xs space-y-2.5 animate-in fade-in slide-in-from-bottom-2 duration-200">
          <div className="flex items-center justify-between gap-2 border-b border-slate-800 pb-2">
            <div className="flex items-center gap-1.5 font-bold text-amber-400">
              <AlertCircle className="w-4 h-4" />
              <span>Prototype Site</span>
            </div>
            <button
              type="button"
              onClick={() => setIsExpanded(false)}
              className="text-slate-400 hover:text-white rounded-lg p-1 hover:bg-slate-800 transition-colors cursor-pointer"
              aria-label="Collapse disclaimer"
            >
              <X className="w-3.5 h-3.5" />
            </button>
          </div>

          <p className="text-slate-300 leading-relaxed">
            Thanks for helping us test this prototype site. Please report any errors to{" "}
            <a 
              href="mailto:support@firebelly.xyz" 
              className="text-emerald-400 hover:text-emerald-300 underline font-semibold transition-colors inline-flex items-center gap-0.5"
            >
              support@firebelly.xyz
            </a>
            .
          </p>

          <div className="flex justify-end pt-1">
            <button
              type="button"
              onClick={() => setIsExpanded(false)}
              className="text-[11px] text-slate-400 hover:text-slate-200 flex items-center gap-1 cursor-pointer transition-colors"
            >
              <span>Minimize</span>
              <ChevronDown className="w-3 h-3" />
            </button>
          </div>
        </div>
      )}
    </aside>
  );
}
