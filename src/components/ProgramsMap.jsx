import React, { useEffect } from "react";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { Sparkles, Coins, Gift, CheckCircle2, MapPin } from "lucide-react";

// Fix standard leaflet marker icon in Vite bundle
const createCustomIcon = (distributionType) => {
  let bgColor = "bg-green-700";
  let symbol = "🌱";

  if (distributionType === 'daily_claim_protocol') {
    bgColor = "bg-purple-700";
    symbol = "🪙";
  } else if (distributionType === 'lottery_raffle') {
    bgColor = "bg-amber-600";
    symbol = "🎁";
  }

  return L.divIcon({
    className: "custom-leaflet-marker",
    html: `
      <div style="
        width: 34px; 
        height: 34px; 
        border-radius: 50%; 
        display: flex; 
        align-items: center; 
        justify-content: center; 
        background-color: ${distributionType === 'daily_claim_protocol' ? '#7e22ce' : distributionType === 'lottery_raffle' ? '#d97706' : '#15803d'}; 
        color: white; 
        font-size: 16px; 
        box-shadow: 0 4px 10px rgba(0,0,0,0.3); 
        border: 2px solid white;
      ">
        ${symbol}
      </div>
    `,
    iconSize: [34, 34],
    iconAnchor: [17, 17],
    popupAnchor: [0, -18]
  });
};

export default function ProgramsMap({ programs }) {
  const navigate = useNavigate();

  // Filter programs that have valid coordinates
  const geocodedPrograms = (programs || []).filter(
    p => p.latitude && p.longitude && !isNaN(Number(p.latitude)) && !isNaN(Number(p.longitude))
  );

  return (
    <div className="w-full h-[600px] rounded-2xl overflow-hidden shadow-lg border border-green-200 relative z-0">
      <MapContainer
        center={[30, -10]}
        zoom={2}
        minZoom={2}
        maxZoom={14}
        scrollWheelZoom={true}
        className="w-full h-full"
      >
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
          url="https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png"
        />

        {geocodedPrograms.map((program) => {
          const lat = Number(program.latitude);
          const lng = Number(program.longitude);
          const monthlyUsd = Number(program.monthly_amount_usd || 0);

          return (
            <Marker 
              key={program.id} 
              position={[lat, lng]} 
              icon={createCustomIcon(program.distribution_type)}
            >
              <Popup className="custom-program-popup">
                <div className="p-2 space-y-2 max-w-xs text-left">
                  <div className="flex items-center gap-1.5 flex-wrap">
                    <span className="font-bold text-sm text-green-950 block leading-snug">
                      {program.name}
                    </span>
                    {program.verified && (
                      <span className="text-[10px] bg-green-100 text-green-800 px-1.5 py-0.2 rounded-full font-semibold">
                        Verified
                      </span>
                    )}
                  </div>

                  <p className="text-xs text-gray-500 font-medium">
                    {program.organization}
                  </p>

                  <div className="flex items-center gap-1 text-xs text-emerald-800 font-bold bg-emerald-50 p-1.5 rounded border border-emerald-100">
                    <span>${monthlyUsd.toLocaleString()} USD</span>
                    <span className="text-[10px] font-normal text-gray-600">
                      ({program.amount_description || `${program.currency}`})
                    </span>
                  </div>

                  {program.municipalities && program.municipalities.length > 0 && !program.municipalities.includes('Global') && (
                    <div className="flex items-center gap-1 text-[11px] text-gray-600">
                      <MapPin className="w-3 h-3 text-emerald-600" />
                      <span>{program.municipalities.join(", ")}</span>
                    </div>
                  )}

                  <Button
                    size="sm"
                    onClick={() => navigate('/program-details', { state: { programId: program.program_id } })}
                    className="w-full bg-green-700 hover:bg-green-800 text-white text-xs h-7 mt-1 font-semibold"
                  >
                    View Program Details &rarr;
                  </Button>
                </div>
              </Popup>
            </Marker>
          );
        })}
      </MapContainer>
    </div>
  );
}
