import React from "react";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { MapPin, Zap, ShieldCheck, ExternalLink } from "lucide-react";

// Fallback coordinate dictionary for common regions/cities
const REGION_COORDINATES = {
  // Cities & Regions
  "Evanston": [42.0451, -87.6877],
  "Howard County": [39.2037, -76.8610],
  "Columbia": [39.2037, -76.8610],
  "Philadelphia": [39.9526, -75.1652],
  "Flint": [43.0125, -83.6875],
  "Santa Monica": [34.0195, -118.4912],
  "Los Angeles": [34.0522, -118.2437],
  "Dublin": [53.3498, -6.2603],
  "Gyeonggi": [37.4138, 127.5183],
  "Majuro": [7.1315, 171.1845],
  "Anchorage": [61.2181, -149.9003],
  "Alaska": [64.2008, -149.4937],
  "Macao": [22.1987, 113.5439],
  "Quebec": [46.8139, -71.2080],
  "Canada": [45.4215, -75.6972],
  "Spain": [40.4168, -3.7038],
  "South Africa": [-25.7479, 28.2293],
  "Kenya": [-0.7821, 35.3416],
  "Berlin": [52.5200, 13.4050],
  "Germany": [52.5200, 13.4050],
  "Saudi Arabia": [24.7136, 46.6753],
  "Global": [35.0000, -20.0000],
  "Moncton": [46.0878, -64.7782],
  "Illinois": [40.6331, -89.3985],
  "Maryland": [39.0458, -76.6413],
  "Pennsylvania": [41.2033, -77.1945],
  "Michigan": [44.3148, -85.6024],
  "California": [36.7783, -119.4179],
  "Ireland": [53.1424, -7.6921],
  "South Korea": [35.9078, 127.7669],
  "Marshall Islands": [7.1315, 171.1845]
};

// Fix standard leaflet marker icon in Vite bundle
const createCustomIcon = (distributionType, involvementLevel) => {
  let bgColor = "#15803d"; // green-700
  let symbol = "🌱";

  if (distributionType === 'daily_claim_protocol' || involvementLevel === 'automated_claim') {
    bgColor = "#7e22ce"; // purple-700
    symbol = "🪙";
  } else if (distributionType === 'lottery_raffle') {
    bgColor = "#d97706"; // amber-600
    symbol = "🎁";
  } else if (involvementLevel === 'managed_application') {
    bgColor = "#059669"; // emerald-600
    symbol = "🛡️";
  }

  return L.divIcon({
    className: "custom-leaflet-marker",
    html: `
      <div style="
        width: 36px; 
        height: 36px; 
        border-radius: 50%; 
        display: flex; 
        align-items: center; 
        justify-content: center; 
        background-color: ${bgColor}; 
        color: white; 
        font-size: 17px; 
        box-shadow: 0 4px 12px rgba(0,0,0,0.35); 
        border: 2.5px solid white;
        cursor: pointer;
        transition: transform 0.2s ease;
      ">
        ${symbol}
      </div>
    `,
    iconSize: [36, 36],
    iconAnchor: [18, 18],
    popupAnchor: [0, -20]
  });
};

function getCoordinates(program, index = 0) {
  let lat = null;
  let lng = null;

  if (program.latitude && program.longitude && !isNaN(Number(program.latitude)) && !isNaN(Number(program.longitude))) {
    lat = Number(program.latitude);
    lng = Number(program.longitude);
  } else {
    // Try municipalities
    if (program.municipalities && program.municipalities.length > 0) {
      for (const m of program.municipalities) {
        if (REGION_COORDINATES[m]) {
          [lat, lng] = REGION_COORDINATES[m];
          break;
        }
      }
    }
    // Try required states
    if (lat === null && program.required_states && program.required_states.length > 0) {
      for (const s of program.required_states) {
        if (REGION_COORDINATES[s]) {
          [lat, lng] = REGION_COORDINATES[s];
          break;
        }
      }
    }
    // Try available regions
    if (lat === null && program.available_regions && program.available_regions.length > 0) {
      for (const r of program.available_regions) {
        if (REGION_COORDINATES[r]) {
          [lat, lng] = REGION_COORDINATES[r];
          break;
        }
      }
    }
  }

  if (lat === null || lng === null) {
    return null;
  }

  // Slight jitter for programs sharing identical coordinates (e.g. multi-programs in same city)
  const jitterOffset = (index % 5) * 0.008;
  return [lat + jitterOffset, lng + jitterOffset];
}

export default function ProgramsMap({ programs }) {
  const navigate = useNavigate();

  // Extract valid programs with resolved coordinates
  const mappedPrograms = (programs || [])
    .map((program, idx) => {
      const coords = getCoordinates(program, idx);
      return coords ? { ...program, coords } : null;
    })
    .filter(Boolean);

  return (
    <div className="w-full relative">
      <div className="w-full h-[620px] rounded-2xl overflow-hidden shadow-xl border border-green-200 relative z-0">
        <MapContainer
          center={[25, 5]}
          zoom={2}
          minZoom={2}
          maxZoom={15}
          scrollWheelZoom={true}
          className="w-full h-full"
        >
          <TileLayer
            attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
            url="https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png"
          />

          {mappedPrograms.map((program) => {
            const monthlyUsd = Number(program.monthly_amount_usd || 0);
            const programKey = program.program_id || program.id || program.name;

            return (
              <Marker 
                key={programKey} 
                position={program.coords} 
                icon={createCustomIcon(program.distribution_type, program.involvement_level)}
              >
                <Popup className="custom-program-popup">
                  <div className="p-3 space-y-2.5 max-w-xs text-left">
                    <div className="flex items-center gap-1.5 flex-wrap">
                      <span className="font-bold text-sm text-green-950 block leading-snug">
                        {program.name}
                      </span>
                      {program.verified && (
                        <span className="text-[10px] bg-green-100 text-green-800 px-1.5 py-0.5 rounded-full font-semibold">
                          Verified
                        </span>
                      )}
                    </div>

                    <p className="text-xs text-gray-500 font-medium">
                      {program.organization}
                    </p>

                    <div className="flex items-center gap-1 text-xs text-emerald-800 font-bold bg-emerald-50 p-2 rounded-lg border border-emerald-100">
                      <span>${monthlyUsd.toLocaleString()} USD</span>
                      <span className="text-[10px] font-normal text-gray-600">
                        ({program.amount_description || `${program.currency}`})
                      </span>
                    </div>

                    {program.municipalities && program.municipalities.length > 0 && !program.municipalities.includes('Global') && (
                      <div className="flex items-center gap-1 text-[11px] text-gray-600">
                        <MapPin className="w-3.5 h-3.5 text-emerald-600 flex-shrink-0" />
                        <span>{program.municipalities.join(", ")}</span>
                      </div>
                    )}

                    <div className="pt-1">
                      {program.involvement_level === 'automated_claim' ? (
                        <Button
                          size="sm"
                          onClick={() => navigate(program.custom_claim_path || '/claim/gooddollar')}
                          className="w-full bg-purple-700 hover:bg-purple-800 text-white text-xs h-8 font-semibold flex items-center justify-center gap-1.5"
                        >
                          <Zap className="w-3 h-3" /> Open Claim Terminal &rarr;
                        </Button>
                      ) : (
                        <Button
                          size="sm"
                          onClick={() => navigate('/program-details', { state: { programId: program.program_id } })}
                          className="w-full bg-green-700 hover:bg-green-800 text-white text-xs h-8 font-semibold"
                        >
                          View Program Details &rarr;
                        </Button>
                      )}
                    </div>
                  </div>
                </Popup>
              </Marker>
            );
          })}
        </MapContainer>
      </div>

      {/* Map Legend Bar */}
      <div className="mt-3 flex flex-wrap items-center justify-between gap-3 px-4 py-2.5 bg-white rounded-xl border border-gray-200 shadow-sm text-xs text-gray-600">
        <div className="flex items-center gap-4 flex-wrap">
          <span className="font-semibold text-gray-800">Map Legend:</span>
          <span className="flex items-center gap-1.5">
            <span className="w-4 h-4 rounded-full bg-green-700 text-white flex items-center justify-center text-[10px]">🌱</span>
            Guaranteed Cash Pilot
          </span>
          <span className="flex items-center gap-1.5">
            <span className="w-4 h-4 rounded-full bg-purple-700 text-white flex items-center justify-center text-[10px]">🪙</span>
            Web3 Daily Claim Protocol
          </span>
          <span className="flex items-center gap-1.5">
            <span className="w-4 h-4 rounded-full bg-amber-600 text-white flex items-center justify-center text-[10px]">🎁</span>
            Lottery / Raffle
          </span>
        </div>
        <span className="font-medium text-emerald-800 bg-emerald-50 px-2 py-0.5 rounded-full border border-emerald-200">
          Showing {mappedPrograms.length} Geocoded Programs
        </span>
      </div>
    </div>
  );
}
