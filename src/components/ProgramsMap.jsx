import React, { useState, useEffect } from "react";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { MapPin, Zap, ShieldCheck, ExternalLink, Heart } from "lucide-react";
import { getSupporterStatus } from "@/lib/supporterPoints";
import SupporterGateModal from "@/components/SupporterGateModal";

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
  "Chicago": [41.8781, -87.6298],
  "Cook County": [41.8781, -87.6298],
  "Stockton": [37.9577, -121.2908],
  "San Joaquin County": [37.9577, -121.2908],
  "Sacramento": [38.5816, -121.4944],
  "Jackson": [32.2988, -90.1848],
  "Saint Paul": [44.9537, -93.0900],
  "Otter Tail County": [46.4116, -95.7144],
  "Boston": [42.3601, -71.0589],
  "Baltimore": [39.2904, -76.6122],
  "Appalachia": [37.5000, -82.5000],
  "Illinois": [40.6331, -89.3985],
  "Maryland": [39.0458, -76.6413],
  "Pennsylvania": [41.2033, -77.1945],
  "Michigan": [44.3148, -85.6024],
  "California": [36.7783, -119.4179],
  "Mississippi": [32.3547, -89.3985],
  "Minnesota": [46.7296, -94.6859],
  "Massachusetts": [42.4072, -71.3824],
  "Arkansas": [35.2010, -91.8318],
  "Kentucky": [37.8393, -84.2700],
  "Ohio": [40.4173, -82.9071],
  "West Virginia": [38.5976, -80.4549],
  "Tennessee": [35.5175, -86.5804],
  "Pittsburgh": [40.4406, -79.9959],
  "Allegheny County": [40.4406, -79.9959],
  "Maricá": [-22.9194, -42.8186],
  "Niterói": [-22.8833, -43.1036],
  "Saquarema": [-22.9200, -42.5100],
  "Seoul": [37.5665, 126.9780],
  "Warsaw": [52.2297, 21.0122],
  "Poland": [51.9194, 19.1451],
  "Brazil": [-14.2350, -51.9253],
  "Rio de Janeiro": [-22.9068, -43.1729],
  "Mazovia": [52.2297, 21.0122],
  "Ireland": [53.1424, -7.6921],
  "South Korea": [35.9078, 127.7669],
  "Marshall Islands": [7.1315, 171.1845]
};

// Fix standard leaflet marker icon in Vite bundle
const createCustomIcon = (distributionType, involvementLevel) => {
  let bgColor = "#15803d"; // green-700
  let symbol = "🌱";

  if (distributionType === 'permanent_statewide') {
    bgColor = "#1e40af"; // blue-800
    symbol = "🏛️";
  } else if (distributionType === 'daily_claim_protocol' || involvementLevel === 'automated_claim') {
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

  const [isGated, setIsGated] = useState(false);
  const [supporterModalOpen, setSupporterModalOpen] = useState(false);

  useEffect(() => {
    getSupporterStatus().then(st => setIsGated(st.isGated && !st.hasDonated));
  }, []);

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
            attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
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

                    <div className="flex flex-col gap-0.5 text-xs text-emerald-800 font-bold bg-emerald-50 p-2 rounded-lg border border-emerald-100">
                      <div className="flex items-center gap-1">
                        <span>${monthlyUsd.toLocaleString()} USD</span>
                        <span className="text-[10px] text-gray-500 font-normal">/ mo</span>
                      </div>
                      {program.amount_description && (
                        <span className="text-[10px] font-normal text-gray-600 leading-tight mt-0.5 block">
                          {program.amount_description}
                        </span>
                      )}
                    </div>

                    {program.municipalities && program.municipalities.length > 0 && !program.municipalities.includes('Global') && (
                      <div className="flex items-center gap-1 text-[11px] text-gray-600">
                        <MapPin className="w-3.5 h-3.5 text-emerald-600 flex-shrink-0" />
                        <span>{program.municipalities.join(", ")}</span>
                      </div>
                    )}

                    {isGated ? (
                      <div className="pt-2 border-t border-emerald-100 space-y-1.5 text-center">
                        <p className="text-[11px] text-gray-600 leading-snug">
                          Support our volunteer community to view full application details & direct links.
                        </p>
                        <Button
                          size="sm"
                          onClick={() => setSupporterModalOpen(true)}
                          className="w-full bg-emerald-600 hover:bg-emerald-700 text-white text-xs h-8 font-semibold flex items-center justify-center gap-1.5"
                        >
                          <Heart className="w-3.5 h-3.5 text-pink-300 fill-pink-300" />
                          <span>Support to Unlock &rarr;</span>
                        </Button>
                      </div>
                    ) : (
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
                    )}
                  </div>
                </Popup>
              </Marker>
            );
          })}
        </MapContainer>
      </div>

      <SupporterGateModal
        isOpen={supporterModalOpen}
        onClose={() => setSupporterModalOpen(false)}
        featureName="the interactive map"
      />

      {/* Map Legend Bar */}
      <div className="mt-3 flex flex-wrap items-center justify-between gap-3 px-4 py-2.5 bg-white rounded-xl border border-gray-200 shadow-sm text-xs text-gray-600">
        <div className="flex items-center gap-4 flex-wrap">
          <span className="font-semibold text-gray-800">Map Legend:</span>
          <span className="flex items-center gap-1.5">
            <span className="w-4 h-4 rounded-full bg-blue-800 text-white flex items-center justify-center text-[10px]">🏛️</span>
            Permanent Statewide Program
          </span>
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
