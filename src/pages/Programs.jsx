import React, { useState, useEffect, useRef } from "react";
import { supabase } from "@/lib/supabaseClient";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { 
  Leaf, 
  Filter, 
  Search, 
  Plus, 
  Map as MapIcon, 
  List as ListIcon, 
  Coins, 
  Gift, 
  CheckCircle2, 
  Clock,
  History,
  Lock,
  ChevronDown,
  X,
  SlidersHorizontal,
  FileCheck,
  GraduationCap,
  FlaskConical,
  Globe,
  BookOpen,
  Activity,
  Table as TableIcon,
  LayoutGrid,
  ArrowUpDown,
  ArrowUp,
  ArrowDown,
  Star,
  ExternalLink,
  ShieldCheck,
  Zap,
  MapPin,
  Sparkles
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import ProgramList from "../components/dashboard/ProgramList";
import ProgramsMap from "../components/ProgramsMap";
import DonationEncouragementModal from "@/components/DonationEncouragementModal";
import SupporterGateModal from "@/components/SupporterGateModal";
import { recordUsageAction } from "@/lib/supporterPoints";
import { Link } from 'react-router-dom';
import { Switch } from "@/components/ui/switch";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import PageHeader from "@/components/ui/page-header";
import { Helmet } from "react-helmet-async";
import { evaluateEligibility, isProfileComplete } from "@/lib/matchingEngine";

// Multi-select facet dropdown component
function FacetMultiSelect({ label, options, selectedValues = [], onChange }) {
  const [open, setOpen] = useState(false);
  const containerRef = useRef(null);

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (containerRef.current && !containerRef.current.contains(event.target)) {
        setOpen(false);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const toggleOption = (val) => {
    if (selectedValues.includes(val)) {
      onChange(selectedValues.filter(v => v !== val));
    } else {
      onChange([...selectedValues, val]);
    }
  };

  return (
    <div className="relative" ref={containerRef}>
      <Label className="text-xs font-semibold text-gray-700 mb-1 block">{label}</Label>
      <button
        type="button"
        onClick={() => setOpen(!open)}
        className={`w-full bg-white border rounded-lg px-3 py-2 text-xs flex items-center justify-between transition-colors shadow-2xs text-left cursor-pointer ${
          selectedValues.length > 0
            ? "border-green-600 ring-1 ring-green-600 bg-green-50/20"
            : "border-gray-200 hover:border-gray-300"
        }`}
      >
        <span className="truncate text-gray-800 font-medium">
          {selectedValues.length === 0
            ? "All / Any"
            : `${selectedValues.length} selected`}
        </span>
        <ChevronDown className={`w-3.5 h-3.5 text-gray-400 transition-transform ${open ? "rotate-180" : ""}`} />
      </button>

      {open && (
        <div className="absolute z-50 mt-1 w-full min-w-[210px] bg-white rounded-xl shadow-xl border border-gray-200 p-2 space-y-1 max-h-56 overflow-y-auto animate-in fade-in zoom-in-95 duration-100">
          {options.map((opt) => {
            const isSelected = selectedValues.includes(opt.value);
            return (
              <label
                key={opt.value}
                className={`flex items-center gap-2 px-2.5 py-1.5 rounded-lg text-xs cursor-pointer select-none transition-colors ${
                  isSelected ? "bg-green-50 text-green-950 font-semibold" : "hover:bg-gray-50 text-gray-700"
                }`}
              >
                <input
                  type="checkbox"
                  checked={isSelected}
                  onChange={() => toggleOption(opt.value)}
                  className="rounded border-gray-300 text-green-700 focus:ring-green-600 h-3.5 w-3.5"
                />
                <span className="truncate">{opt.label}</span>
              </label>
            );
          })}
        </div>
      )}
    </div>
  );
}

// Program status matcher
export const matchesProgramStatus = (program, statusKey) => {
  const appStatus = (program.application_status || "").toLowerCase();
  const progStatus = (program.status || "").toLowerCase();
  const payoutStatus = (program.payout_status || "").toLowerCase();

  const isPlanned = progStatus === "planned" || appStatus.includes("planned") || progStatus === "upcoming";
  const isHistorical = progStatus === "closed" || progStatus === "completed" || appStatus.includes("pilot completed") || payoutStatus.includes("completed");
  const isClosedOngoing = !isHistorical && (progStatus === "active_closed" || appStatus.includes("no longer accepting") || appStatus.includes("referral") || (payoutStatus.includes("ongoing") && appStatus.includes("no longer")));
  const isAccepting = !isPlanned && !isHistorical && !isClosedOngoing && (
    progStatus === "active_open" ||
    appStatus.includes("accepting") ||
    progStatus === "active" ||
    program.distribution_type === "daily_claim_protocol" ||
    program.distribution_type === "lottery_raffle"
  );

  switch (statusKey) {
    case "accepting_applications":
      return isAccepting;
    case "planned":
      return isPlanned;
    case "closed_ongoing":
      return isClosedOngoing;
    case "closed_historical":
      return isHistorical;
    case "all":
    default:
      return true;
  }
};

export default function Programs() {
  const [programs, setPrograms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [viewMode, setViewMode] = useState("card"); // 'card' | 'table' | 'map'
  const [tableSortColumn, setTableSortColumn] = useState('name');
  const [tableSortDirection, setTableSortDirection] = useState('asc'); // 'asc' | 'desc'

  // Supporter points states
  const [supporterEncouragementOpen, setSupporterEncouragementOpen] = useState(false);
  const [supporterGated, setSupporterGated] = useState(false);

  const handleSwitchToMapView = async () => {
    setViewMode("map");
    const status = await recordUsageAction('MAP_VIEW', user);
    if (status.isGated) {
      setSupporterGated(true);
    } else if (status.shouldEncourage) {
      setSupporterEncouragementOpen(true);
    }
  };

  const handleTableSort = (columnKey) => {
    if (tableSortColumn === columnKey) {
      setTableSortDirection(prev => prev === 'asc' ? 'desc' : 'asc');
    } else {
      setTableSortColumn(columnKey);
      setTableSortDirection('asc');
    }
  };

  // Filter Mode: "quick" (default) or "advanced" (either/or)
  const [filterMode, setFilterMode] = useState("quick");

  // Quick select status filter (Default: "all")
  const [quickFilter, setQuickFilter] = useState("all");

  // Source filter: 'all' | 'stanford' | 'community'
  const [sourceFilter, setSourceFilter] = useState("all");

  // Advanced multi-select facet filters
  const [advancedFilters, setAdvancedFilters] = useState({
    statuses: [],
    countries: [],
    sources: [],
    distributionTypes: [],
    payoutRails: [],
    fundingSources: [],
    involvementLevels: [],
    includeUnverified: false
  });

  const [favoritePrograms, setFavoritePrograms] = useState([]);
  const [userProfile, setUserProfile] = useState(null);
  const [availableCountries, setAvailableCountries] = useState(['all']);
  const [sortField, setSortField] = useState('best_fit'); // 'best_fit' | 'name' | 'amount'
  const [user, setUser] = useState(null);
  
  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);
      
      const { data: { session } } = await supabase.auth.getSession();
      const currentUser = session?.user;
      
      let effectiveProfile = null;

      if (currentUser) {
        let profile = null;
        try {
          const { data } = await supabase.from('users').select('*').eq('id', currentUser.id).maybeSingle();
          profile = data;
        } catch (e) {
          console.warn("Users lookup notice:", e);
        }

        setUser({
          id: currentUser.id,
          email: currentUser.email,
          full_name: profile?.full_name || currentUser.user_metadata?.full_name || currentUser.email?.split('@')[0],
          role: profile?.role || 'user'
        });
        
        let foundProfiles = null;
        let profileId = currentUser.user_metadata?.profile_id || localStorage.getItem("user_profile_id");
        if (profileId) {
          try {
            const { data } = await supabase.from('user_profiles').select('*').eq('id', profileId).limit(1);
            if (data && data.length > 0) foundProfiles = data;
          } catch (e) {
            console.warn("Profile ID lookup notice:", e);
          }
        }

        if (!foundProfiles && currentUser.id) {
          try {
            const { data } = await supabase
              .from('user_profiles')
              .select('*')
              .eq('created_by_id', currentUser.id)
              .order('created_date', { ascending: false });
            if (data && data.length > 0) foundProfiles = data;
          } catch (e) {
            console.warn("created_by_id lookup notice:", e);
          }
        }
          
        if (foundProfiles && foundProfiles.length > 0) {
          effectiveProfile = foundProfiles[0];
          setUserProfile(effectiveProfile);
        }
      }

      if (!effectiveProfile) {
        const stored = localStorage.getItem("user_profile_data") || localStorage.getItem("pendingProfile");
        if (stored) {
          try {
            const parsed = JSON.parse(stored);
            if (parsed && (parsed.country || parsed.income_range || parsed.state || parsed.municipality)) {
              effectiveProfile = parsed;
              setUserProfile(effectiveProfile);
            }
          } catch (e) {
            console.warn("Could not parse stored profile:", e);
          }
        }
      }

      const { data: programsData, error } = await supabase
        .from('programs')
        .select('*')
        .neq('internal_status', 'deleted');
        
      if (error) throw error;
      
      const activePrograms = (programsData || []).filter(p => p.internal_status !== 'deleted');
      setPrograms(activePrograms);

      if (activePrograms.length > 0) {
        setAvailableCountries(['all', ...[...new Set(activePrograms.flatMap(p => p.available_regions || []))].sort()]);
      }
      
      setLoading(false);
    } catch (error) {
      console.error("Error loading data:", error);
      setLoading(false);
    }
  };

  const toggleFavorite = (programId) => {
    const newFavorites = favoritePrograms.includes(programId)
      ? favoritePrograms.filter(id => id !== programId)
      : [...favoritePrograms, programId];
    
    setFavoritePrograms(newFavorites);
    localStorage.setItem('favoritePrograms', JSON.stringify(newFavorites));
  };

  const clearAllFilters = () => {
    setQuickFilter("all");
    setSourceFilter("all");
    setAdvancedFilters({
      statuses: [],
      countries: [],
      sources: [],
      distributionTypes: [],
      payoutRails: [],
      fundingSources: [],
      involvementLevels: [],
      includeUnverified: false
    });
    setSearchTerm("");
    setSortField(hasCompletedProfile ? 'best_fit' : 'name');
  };

  const clearAllAdvancedFilters = () => {
    setAdvancedFilters({
      statuses: [],
      countries: [],
      sources: [],
      distributionTypes: [],
      payoutRails: [],
      fundingSources: [],
      involvementLevels: [],
      includeUnverified: false
    });
  };

  // Determine user authorization & profile completion states
  const isAuthorized = !!user;
  const hasCompletedProfile = Boolean(userProfile && (isProfileComplete(userProfile) || userProfile.country));

  // 1. Evaluate & Attach Match Scores to Programs
  const scoredPrograms = programs.map(program => {
    if (hasCompletedProfile) {
      const matchResult = evaluateEligibility(program, userProfile);
      return {
        ...program,
        matchScore: matchResult.score,
        eligible: matchResult.eligible,
        reasons: matchResult.reasons,
        matchTier: matchResult.tier,
        fitBreakdown: matchResult.fitBreakdown
      };
    }
    return program;
  });

  // 2. Filter Programs with Either/Or logic
  const filteredPrograms = scoredPrograms.filter(program => {
    if (program.internal_status === 'deleted') {
      return false;
    }

    if (searchTerm) {
      const q = searchTerm.toLowerCase();
      const matchName = program.name?.toLowerCase().includes(q);
      const matchDesc = program.description?.toLowerCase().includes(q);
      const matchOrg = program.organization?.toLowerCase().includes(q);
      if (!matchName && !matchDesc && !matchOrg) return false;
    }

    if (filterMode === "quick") {
      // Source filter (Stanford Basic Income Lab vs Community Submissions)
      if (sourceFilter === "stanford") {
        if (program.data_source !== "stanford_basic_income_lab" && !program.stanford_experiment_id) {
          return false;
        }
      } else if (sourceFilter === "community") {
        if (program.data_source === "stanford_basic_income_lab" || program.stanford_experiment_id) {
          return false;
        }
      }

      // Quick Select Mode: Either/Or
      if (!matchesProgramStatus(program, quickFilter)) {
        return false;
      }
      return true;
    } else {
      // Advanced Filters Multi-Select Mode
      if (!advancedFilters.includeUnverified && !program.verified) {
        return false;
      }

      // Source multi-select
      if (advancedFilters.sources && advancedFilters.sources.length > 0) {
        const isStanford = program.data_source === "stanford_basic_income_lab" || !!program.stanford_experiment_id;
        const matchesSource = advancedFilters.sources.some(s => {
          if (s === "stanford") return isStanford;
          if (s === "community") return !isStanford;
          return true;
        });
        if (!matchesSource) return false;
      }

      // Statuses multi-select
      if (advancedFilters.statuses.length > 0) {
        const matchesAny = advancedFilters.statuses.some(st => matchesProgramStatus(program, st));
        if (!matchesAny) return false;
      }

      // Countries multi-select
      if (advancedFilters.countries.length > 0) {
        const programRegions = program.available_regions || [];
        const matchesAnyCountry = advancedFilters.countries.some(c => 
          c === "Global" 
            ? programRegions.some(r => /^(global|worldwide|international|all)$/i.test(r)) || programRegions.length === 0
            : programRegions.includes(c)
        );
        if (!matchesAnyCountry) return false;
      }

      // Distribution Type multi-select
      if (advancedFilters.distributionTypes.length > 0) {
        if (!advancedFilters.distributionTypes.includes(program.distribution_type)) {
          return false;
        }
      }

      // Payout Rail multi-select
      if (advancedFilters.payoutRails.length > 0) {
        if (!advancedFilters.payoutRails.includes(program.payout_rail)) {
          return false;
        }
      }

      // Funding Source multi-select
      if (advancedFilters.fundingSources.length > 0) {
        if (!advancedFilters.fundingSources.includes(program.funding_source)) {
          return false;
        }
      }

      // Involvement Level multi-select
      if (advancedFilters.involvementLevels.length > 0) {
        const progInvolvement = program.involvement_level || 'external_self_apply';
        if (!advancedFilters.involvementLevels.includes(progInvolvement)) {
          return false;
        }
      }

      return true;
    }
  });

  // Dynamic Source Counts Calculation (respects active search and other filters)
  const sourceBasePrograms = scoredPrograms.filter((program) => {
    if (program.internal_status === "deleted") return false;
    if (searchTerm) {
      const q = searchTerm.toLowerCase();
      const matchName = program.name?.toLowerCase().includes(q);
      const matchDesc = program.description?.toLowerCase().includes(q);
      const matchOrg = program.organization?.toLowerCase().includes(q);
      if (!matchName && !matchDesc && !matchOrg) return false;
    }

    if (filterMode === "quick") {
      if (!matchesProgramStatus(program, quickFilter)) return false;
      return true;
    } else {
      if (!advancedFilters.includeUnverified && !program.verified) return false;
      if (advancedFilters.statuses.length > 0) {
        if (!advancedFilters.statuses.some((st) => matchesProgramStatus(program, st))) return false;
      }
      if (advancedFilters.countries.length > 0) {
        const programRegions = program.available_regions || [];
        const matchesAnyCountry = advancedFilters.countries.some((c) =>
          c === "Global"
            ? programRegions.some((r) => /^(global|worldwide|international|all)$/i.test(r)) || programRegions.length === 0
            : programRegions.includes(c)
        );
        if (!matchesAnyCountry) return false;
      }
      if (advancedFilters.distributionTypes.length > 0) {
        if (!advancedFilters.distributionTypes.includes(program.distribution_type)) return false;
      }
      if (advancedFilters.payoutRails.length > 0) {
        if (!advancedFilters.payoutRails.includes(program.payout_rail)) return false;
      }
      if (advancedFilters.fundingSources.length > 0) {
        if (!advancedFilters.fundingSources.includes(program.funding_source)) return false;
      }
      if (advancedFilters.involvementLevels.length > 0) {
        const progInvolvement = program.involvement_level || "external_self_apply";
        if (!advancedFilters.involvementLevels.includes(progInvolvement)) return false;
      }
      return true;
    }
  });

  const sourceCounts = {
    all: sourceBasePrograms.length,
    stanford: sourceBasePrograms.filter((p) => p.data_source === "stanford_basic_income_lab" || p.stanford_experiment_id).length,
    community: sourceBasePrograms.filter((p) => p.data_source !== "stanford_basic_income_lab" && !p.stanford_experiment_id).length,
  };

  // Dynamic Status Counts Calculation (respects active search and sourceFilter)
  const statusBasePrograms = scoredPrograms.filter((program) => {
    if (program.internal_status === "deleted") return false;
    if (searchTerm) {
      const q = searchTerm.toLowerCase();
      const matchName = program.name?.toLowerCase().includes(q);
      const matchDesc = program.description?.toLowerCase().includes(q);
      const matchOrg = program.organization?.toLowerCase().includes(q);
      if (!matchName && !matchDesc && !matchOrg) return false;
    }

    if (filterMode === "quick") {
      if (sourceFilter === "stanford") {
        if (program.data_source !== "stanford_basic_income_lab" && !program.stanford_experiment_id) {
          return false;
        }
      } else if (sourceFilter === "community") {
        if (program.data_source === "stanford_basic_income_lab" || program.stanford_experiment_id) {
          return false;
        }
      }
      return true;
    } else {
      if (!advancedFilters.includeUnverified && !program.verified) return false;
      if (advancedFilters.sources && advancedFilters.sources.length > 0) {
        const isStanford = program.data_source === "stanford_basic_income_lab" || !!program.stanford_experiment_id;
        const matchesSource = advancedFilters.sources.some(s => {
          if (s === "stanford") return isStanford;
          if (s === "community") return !isStanford;
          return true;
        });
        if (!matchesSource) return false;
      }
      if (advancedFilters.countries.length > 0) {
        const programRegions = program.available_regions || [];
        const matchesAnyCountry = advancedFilters.countries.some((c) =>
          c === "Global"
            ? programRegions.some((r) => /^(global|worldwide|international|all)$/i.test(r)) || programRegions.length === 0
            : programRegions.includes(c)
        );
        if (!matchesAnyCountry) return false;
      }
      if (advancedFilters.distributionTypes.length > 0) {
        if (!advancedFilters.distributionTypes.includes(program.distribution_type)) return false;
      }
      if (advancedFilters.payoutRails.length > 0) {
        if (!advancedFilters.payoutRails.includes(program.payout_rail)) return false;
      }
      if (advancedFilters.fundingSources.length > 0) {
        if (!advancedFilters.fundingSources.includes(program.funding_source)) return false;
      }
      if (advancedFilters.involvementLevels.length > 0) {
        const progInvolvement = program.involvement_level || "external_self_apply";
        if (!advancedFilters.involvementLevels.includes(progInvolvement)) return false;
      }
      return true;
    }
  });

  const statusCounts = {
    all: statusBasePrograms.length,
    accepting_applications: statusBasePrograms.filter((p) => matchesProgramStatus(p, "accepting_applications")).length,
    planned: statusBasePrograms.filter((p) => matchesProgramStatus(p, "planned")).length,
    closed_ongoing: statusBasePrograms.filter((p) => matchesProgramStatus(p, "closed_ongoing")).length,
    closed_historical: statusBasePrograms.filter((p) => matchesProgramStatus(p, "closed_historical")).length,
  };

  // 3. Sort Programs (Dynamic by viewMode)
  const sortedPrograms = [...filteredPrograms].sort((a, b) => {
    if (viewMode === 'table') {
      let diff = 0;
      if (tableSortColumn === 'name') {
        diff = (a.name || '').localeCompare(b.name || '');
      } else if (tableSortColumn === 'organization') {
        diff = (a.organization || '').localeCompare(b.organization || '');
      } else if (tableSortColumn === 'location') {
        const locA = (a.municipalities?.[0] || a.required_states?.[0] || a.available_regions?.[0] || '');
        const locB = (b.municipalities?.[0] || b.required_states?.[0] || b.available_regions?.[0] || '');
        diff = locA.localeCompare(locB);
      } else if (tableSortColumn === 'amount') {
        diff = Number(a.monthly_amount_usd || 0) - Number(b.monthly_amount_usd || 0);
      } else if (tableSortColumn === 'status') {
        const stA = (a.application_status || a.status || '');
        const stB = (b.application_status || b.status || '');
        diff = stA.localeCompare(stB);
      } else if (tableSortColumn === 'matchScore') {
        diff = Number(a.matchScore || 0) - Number(b.matchScore || 0);
      } else if (tableSortColumn === 'source') {
        const srcA = a.data_source || '';
        const srcB = b.data_source || '';
        diff = srcA.localeCompare(srcB);
      } else {
        diff = (a.name || '').localeCompare(b.name || '');
      }
      return tableSortDirection === 'asc' ? diff : -diff;
    }

    // Default card & map mode sorting
    if (sortField === 'best_fit' && hasCompletedProfile) {
      const scoreA = a.matchScore ?? 0;
      const scoreB = b.matchScore ?? 0;
      if (scoreB !== scoreA) {
        return scoreB - scoreA; // Highest score first
      }
      const amountA = Number(a.monthly_amount_usd || 0);
      const amountB = Number(b.monthly_amount_usd || 0);
      return amountB - amountA;
    }

    if (sortField === 'amount') {
      const amountA = Number(a.monthly_amount_usd || 0);
      const amountB = Number(b.monthly_amount_usd || 0);
      return amountB - amountA;
    }

    return (a.name || '').localeCompare(b.name || '');
  });

  // Active chips generator for Advanced Filters mode
  const activeFilterChips = [];
  if (filterMode === "advanced") {
    if (advancedFilters.sources && advancedFilters.sources.length > 0) {
      const sourceLabels = {
        stanford: "Stanford Basic Income Lab",
        community: "Community Submissions",
      };
      advancedFilters.sources.forEach((s) => {
        activeFilterChips.push({
          id: `source-${s}`,
          facet: "sources",
          value: s,
          category: "Source",
          label: sourceLabels[s] || s,
        });
      });
    }

    const statusLabels = {
      accepting_applications: "Accepting applications",
      planned: "Planned",
      closed_ongoing: "Closed, ongoing",
      closed_historical: "Closed, historical",
    };
    advancedFilters.statuses.forEach((st) => {
      activeFilterChips.push({
        id: `status-${st}`,
        facet: "statuses",
        value: st,
        category: "Status",
        label: statusLabels[st] || st,
      });
    });

    advancedFilters.countries.forEach((c) => {
      activeFilterChips.push({
        id: `country-${c}`,
        facet: "countries",
        value: c,
        category: "Country",
        label: c,
      });
    });

    const distLabels = {
      permanent_statewide: "Permanent Statewide Program",
      guaranteed_recurrent: "Guaranteed Monthly (Pilot)",
      daily_claim_protocol: "Daily Claim Protocol",
      lottery_raffle: "Lottery / Raffle",
    };
    advancedFilters.distributionTypes.forEach((dt) => {
      activeFilterChips.push({
        id: `dist-${dt}`,
        facet: "distributionTypes",
        value: dt,
        category: "Distribution",
        label: distLabels[dt] || dt,
      });
    });

    const railLabels = {
      direct_deposit: "Direct Deposit / ACH",
      prepaid_card: "Prepaid Card",
      crypto_wallet: "Crypto Wallet",
      mobile_money: "Mobile Money",
    };
    advancedFilters.payoutRails.forEach((pr) => {
      activeFilterChips.push({
        id: `rail-${pr}`,
        facet: "payoutRails",
        value: pr,
        category: "Payout Rail",
        label: railLabels[pr] || pr,
      });
    });

    const fundingLabels = {
      municipal_government: "Municipal Government",
      state_federal: "State / Federal",
      philanthropic_grant: "Philanthropic Grant",
      protocol_yield: "Protocol Yield",
      community_crowdfund: "Crowdfunded",
    };
    advancedFilters.fundingSources.forEach((fs) => {
      activeFilterChips.push({
        id: `funding-${fs}`,
        facet: "fundingSources",
        value: fs,
        category: "Funding",
        label: fundingLabels[fs] || fs,
      });
    });

    const involvementLabels = {
      managed_application: "Managed Application",
      automated_claim: "Automated Claim Protocol",
      external_self_apply: "External Self-Apply",
    };
    advancedFilters.involvementLevels.forEach((il) => {
      activeFilterChips.push({
        id: `involvement-${il}`,
        facet: "involvementLevels",
        value: il,
        category: "Involvement",
        label: involvementLabels[il] || il,
      });
    });
  }

  const removeChip = (chip) => {
    setAdvancedFilters((prev) => ({
      ...prev,
      [chip.facet]: prev[chip.facet].filter((v) => v !== chip.value),
    }));
  };

  return (
    <>
      <Helmet>
        <title>Browse All UBI Programs, Daily Claims & Lotteries | UBI Finder</title>
        <meta name="description" content="Search verified guaranteed basic income pilots, Web3 daily claim protocols, and community raffles with our interactive map and rail filters." />
      </Helmet>

      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-5xl mx-auto space-y-6">
          
          <PageHeader 
            icon={Leaf}
            title="Global UBI Programs Directory"
            subtitle="Explore active municipal pilots, Web3 daily claim protocols, and community-funded basic income distributions worldwide."
          />

          {/* ========================================================================= */}
          {/* FILTER CONTROLS: EITHER QUICK SELECT OR ADVANCED FILTERS */}
          {/* ========================================================================= */}
          {filterMode === "quick" ? (
            <div className="space-y-2.5">
              {/* Row 1: Status Filter Pills */}
              <div className="flex flex-wrap items-center gap-2">
                <span className="text-xs font-semibold text-gray-500 mr-1 flex items-center gap-1">
                  <Activity className="w-3.5 h-3.5 text-gray-400" /> Status:
                </span>

                <button
                  type="button"
                  onClick={() => setQuickFilter("all")}
                  className={`px-3.5 py-1.5 rounded-full text-xs font-semibold transition-all cursor-pointer ${
                    quickFilter === "all"
                      ? "bg-green-800 text-white shadow-sm ring-1 ring-green-800"
                      : "bg-white text-gray-700 hover:bg-green-50 border border-gray-200"
                  }`}
                >
                  All ({statusCounts.all})
                </button>

                <button
                  type="button"
                  onClick={() => setQuickFilter("accepting_applications")}
                  className={`px-3.5 py-1.5 rounded-full text-xs font-semibold transition-all flex items-center gap-1.5 cursor-pointer ${
                    quickFilter === "accepting_applications"
                      ? "bg-emerald-700 text-white shadow-sm ring-1 ring-emerald-700"
                      : "bg-white text-emerald-800 hover:bg-emerald-50 border border-emerald-200"
                  }`}
                >
                  <CheckCircle2 className="w-3.5 h-3.5" />
                  Open, ongoing ({statusCounts.accepting_applications})
                </button>

                <button
                  type="button"
                  onClick={() => setQuickFilter("planned")}
                  className={`px-3.5 py-1.5 rounded-full text-xs font-semibold transition-all flex items-center gap-1.5 cursor-pointer ${
                    quickFilter === "planned"
                      ? "bg-blue-700 text-white shadow-sm ring-1 ring-blue-700"
                      : "bg-white text-blue-800 hover:bg-blue-50 border border-blue-200"
                  }`}
                >
                  <Clock className="w-3.5 h-3.5" />
                  Planned ({statusCounts.planned})
                </button>

                <button
                  type="button"
                  onClick={() => setQuickFilter("closed_ongoing")}
                  className={`px-3.5 py-1.5 rounded-full text-xs font-semibold transition-all flex items-center gap-1.5 cursor-pointer ${
                    quickFilter === "closed_ongoing"
                      ? "bg-purple-700 text-white shadow-sm ring-1 ring-purple-700"
                      : "bg-white text-purple-800 hover:bg-purple-50 border border-purple-200"
                  }`}
                >
                  <Coins className="w-3.5 h-3.5" />
                  Closed, ongoing ({statusCounts.closed_ongoing})
                </button>

                <button
                  type="button"
                  onClick={() => setQuickFilter("closed_historical")}
                  className={`px-3.5 py-1.5 rounded-full text-xs font-semibold transition-all flex items-center gap-1.5 cursor-pointer ${
                    quickFilter === "closed_historical"
                      ? "bg-gray-700 text-white shadow-sm ring-1 ring-gray-700"
                      : "bg-white text-gray-600 hover:bg-gray-100 border border-gray-200"
                  }`}
                >
                  <History className="w-3.5 h-3.5" />
                  Closed, historical ({statusCounts.closed_historical})
                </button>
              </div>

              {/* Row 2: Source Filter Pills & Right-Aligned Submit Button */}
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-2 border-t border-gray-100/90">
                <div className="flex flex-wrap items-center gap-2">
                  <span className="text-xs font-semibold text-gray-500 mr-1 flex items-center gap-1">
                    <BookOpen className="w-3.5 h-3.5 text-gray-400" /> Source:
                  </span>
                  <button
                    type="button"
                    onClick={() => setSourceFilter("all")}
                    className={`px-3 py-1 rounded-full text-xs font-semibold transition-all cursor-pointer ${
                      sourceFilter === "all"
                        ? "bg-slate-800 text-white shadow-xs ring-1 ring-slate-800"
                        : "bg-white text-gray-700 hover:bg-gray-100 border border-gray-200"
                    }`}
                  >
                    All Sources ({sourceCounts.all})
                  </button>
                  <button
                    type="button"
                    onClick={() => setSourceFilter("stanford")}
                    className={`px-3 py-1 rounded-full text-xs font-semibold transition-all flex items-center gap-1.5 cursor-pointer ${
                      sourceFilter === "stanford"
                        ? "bg-red-800 text-white shadow-xs ring-1 ring-red-800"
                        : "bg-white text-red-900 hover:bg-red-50 border border-red-200"
                    }`}
                  >
                    <GraduationCap className="w-3.5 h-3.5 text-red-600" />
                    Stanford Basic Income Lab ({sourceCounts.stanford})
                  </button>
                  <button
                    type="button"
                    onClick={() => setSourceFilter("community")}
                    className={`px-3 py-1 rounded-full text-xs font-semibold transition-all flex items-center gap-1.5 cursor-pointer ${
                      sourceFilter === "community"
                        ? "bg-emerald-800 text-white shadow-xs ring-1 ring-emerald-800"
                        : "bg-white text-emerald-900 hover:bg-emerald-50 border border-emerald-200"
                    }`}
                  >
                    <Globe className="w-3.5 h-3.5 text-emerald-600" />
                    Community Submissions ({sourceCounts.community})
                  </button>
                </div>

                <Link to={user ? "/Submit-Program" : "/login?view=signup&redirectTo=/Submit-Program"} className="flex-shrink-0">
                  <Button className="bg-green-700 hover:bg-green-800 text-xs shadow-sm h-8 cursor-pointer">
                    <Plus className="w-3.5 h-3.5 mr-1" />
                    Submit Program
                  </Button>
                </Link>
              </div>

              {/* Row 3: Advanced Filters (Left), Result Count (Center), List/Map Switcher (Right) */}
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-2 border-t border-gray-100/90">
                {/* Left: Advanced filters button */}
                <div className="flex items-center">
                  <button
                    type="button"
                    onClick={() => setFilterMode("advanced")}
                    className="text-xs text-gray-500 hover:text-green-800 underline transition-colors cursor-pointer inline-flex items-center gap-1.5 font-medium"
                  >
                    <SlidersHorizontal className="w-3.5 h-3.5 text-gray-400" />
                    <span>Advanced filters</span>
                  </button>
                </div>

                {/* Center: Result Count Resultant */}
                <div className="text-xs text-gray-600 text-center font-medium">
                  Showing <strong className="text-green-950 font-bold text-sm">{sortedPrograms.length}</strong> of {programs.length} programs
                </div>

                {/* Right: Table View / Card View / Map View Switcher */}
                <div className="bg-gray-100 p-1 rounded-xl flex items-center border border-gray-200 self-end sm:self-auto">
                  <button
                    onClick={() => setViewMode("table")}
                    className={`px-3 py-1 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-all cursor-pointer ${
                      viewMode === "table" 
                        ? "bg-white text-green-950 shadow-sm" 
                        : "text-gray-600 hover:text-gray-900"
                    }`}
                  >
                    <TableIcon className="w-3.5 h-3.5" />
                    Table View
                  </button>
                  <button
                    onClick={() => setViewMode("card")}
                    className={`px-3 py-1 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-all cursor-pointer ${
                      viewMode === "card" 
                        ? "bg-white text-green-950 shadow-sm" 
                        : "text-gray-600 hover:text-gray-900"
                    }`}
                  >
                    <LayoutGrid className="w-3.5 h-3.5" />
                    Card View
                  </button>
                  <button
                    onClick={handleSwitchToMapView}
                    className={`px-3 py-1 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-all cursor-pointer ${
                      viewMode === "map" 
                        ? "bg-white text-green-950 shadow-sm" 
                        : "text-gray-600 hover:text-gray-900"
                    }`}
                  >
                    <MapIcon className="w-3.5 h-3.5" />
                    Map View
                  </button>
                </div>
              </div>
            </div>
          ) : (
            /* Advanced Filters Panel (Either/Or Mode: Quick Select is hidden) */
            <Card className="shadow-sm border-gray-200 bg-white/95 animate-in fade-in duration-200">
              <CardHeader className="py-3 px-5 border-b border-gray-100 bg-gray-50/50">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <SlidersHorizontal className="w-4 h-4 text-green-700" />
                    <CardTitle className="text-sm font-bold text-gray-900">Advanced Filters</CardTitle>
                    <span className="text-xs text-gray-400 font-normal">
                      (Multi-select options to customize your filter query)
                    </span>
                  </div>
                  <button
                    type="button"
                    onClick={() => {
                      clearAllAdvancedFilters();
                      setFilterMode("quick");
                    }}
                    className="text-xs text-gray-500 hover:text-green-800 underline transition-colors cursor-pointer flex items-center gap-1"
                  >
                    ← Back to quick filters
                  </button>
                </div>
              </CardHeader>

              <CardContent className="p-5 space-y-4">
                {/* 7 Multi-Select Dropdown Facets */}
                <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-7 gap-2.5">
                  <FacetMultiSelect
                    label="Source / Origin"
                    options={[
                      { value: "stanford", label: "Stanford Basic Income Lab" },
                      { value: "community", label: "Community Submissions" },
                    ]}
                    selectedValues={advancedFilters.sources}
                    onChange={(vals) => setAdvancedFilters((prev) => ({ ...prev, sources: vals }))}
                  />

                  <FacetMultiSelect
                    label="Application Status"
                    options={[
                      { value: "accepting_applications", label: "Accepting applications" },
                      { value: "planned", label: "Planned" },
                      { value: "closed_ongoing", label: "Closed, ongoing" },
                      { value: "closed_historical", label: "Closed, historical" },
                    ]}
                    selectedValues={advancedFilters.statuses}
                    onChange={(vals) => setAdvancedFilters((prev) => ({ ...prev, statuses: vals }))}
                  />

                  <FacetMultiSelect
                    label="Country / Region"
                    options={availableCountries.filter((c) => c !== "all").map((c) => ({
                      value: c,
                      label: c,
                    }))}
                    selectedValues={advancedFilters.countries}
                    onChange={(vals) => setAdvancedFilters((prev) => ({ ...prev, countries: vals }))}
                  />

                  <FacetMultiSelect
                    label="Distribution Model"
                    options={[
                      { value: "permanent_statewide", label: "Permanent Statewide Program" },
                      { value: "guaranteed_recurrent", label: "Guaranteed Monthly (Pilot)" },
                      { value: "daily_claim_protocol", label: "Daily Claim Protocol" },
                      { value: "lottery_raffle", label: "Lottery / Raffle" },
                    ]}
                    selectedValues={advancedFilters.distributionTypes}
                    onChange={(vals) => setAdvancedFilters((prev) => ({ ...prev, distributionTypes: vals }))}
                  />

                  <FacetMultiSelect
                    label="Delivery Rail"
                    options={[
                      { value: "direct_deposit", label: "Direct Deposit / ACH" },
                      { value: "prepaid_card", label: "Prepaid Card" },
                      { value: "crypto_wallet", label: "Crypto Wallet" },
                      { value: "mobile_money", label: "Mobile Money" },
                    ]}
                    selectedValues={advancedFilters.payoutRails}
                    onChange={(vals) => setAdvancedFilters((prev) => ({ ...prev, payoutRails: vals }))}
                  />

                  <FacetMultiSelect
                    label="Funding Source"
                    options={[
                      { value: "municipal_government", label: "Municipal Government" },
                      { value: "state_federal", label: "State / Federal" },
                      { value: "philanthropic_grant", label: "Philanthropic Grant" },
                      { value: "protocol_yield", label: "Protocol Yield" },
                      { value: "community_crowdfund", label: "Crowdfunded" },
                    ]}
                    selectedValues={advancedFilters.fundingSources}
                    onChange={(vals) => setAdvancedFilters((prev) => ({ ...prev, fundingSources: vals }))}
                  />

                  <FacetMultiSelect
                    label="Involvement Level"
                    options={[
                      { value: "managed_application", label: "Managed Application" },
                      { value: "automated_claim", label: "Automated Claim" },
                      { value: "external_self_apply", label: "External Self-Apply" },
                    ]}
                    selectedValues={advancedFilters.involvementLevels}
                    onChange={(vals) => setAdvancedFilters((prev) => ({ ...prev, involvementLevels: vals }))}
                  />
                </div>

                <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 pt-2 border-t border-gray-100">
                  <div className="flex items-center space-x-2">
                    <Switch
                      id="include-unverified"
                      checked={advancedFilters.includeUnverified}
                      onCheckedChange={(checked) =>
                        setAdvancedFilters((prev) => ({ ...prev, includeUnverified: checked }))
                      }
                    />
                    <Label htmlFor="include-unverified" className="text-xs text-gray-700 cursor-pointer">
                      Include unverified / community-submitted programs
                    </Label>
                  </div>

                  {activeFilterChips.length > 0 && (
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={clearAllAdvancedFilters}
                      className="text-xs text-red-600 hover:text-red-700 hover:bg-red-50 h-7"
                    >
                      Clear All Selected ({activeFilterChips.length})
                    </Button>
                  )}
                </div>

                {/* Active Filter Chips with 'x' to remove */}
                {activeFilterChips.length > 0 && (
                  <div className="flex flex-wrap items-center gap-1.5 pt-2 border-t border-gray-100">
                    <span className="text-[11px] font-bold text-gray-400 mr-1 uppercase">
                      Active filters:
                    </span>
                    {activeFilterChips.map((chip) => (
                      <span
                        key={chip.id}
                        className="inline-flex items-center gap-1 bg-green-50 border border-green-200 text-green-900 text-xs px-2.5 py-1 rounded-full font-medium shadow-2xs"
                      >
                        <span>
                          <strong className="text-green-950">{chip.category}:</strong> {chip.label}
                        </span>
                        <button
                          type="button"
                          onClick={() => removeChip(chip)}
                          className="w-4 h-4 rounded-full inline-flex items-center justify-center text-green-700 hover:bg-green-200 hover:text-green-950 transition-colors ml-0.5 cursor-pointer"
                          title={`Remove ${chip.label}`}
                        >
                          <X className="w-3 h-3" />
                        </button>
                      </span>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          )}

          {/* ========================================================================= */}
          {/* USER STATUS / PERSONALIZATION CALLOUT BANNERS */}
          {/* ========================================================================= */}
          
          {/* Condition 1: Non-Authorized Users (Prompt to Log In) */}
          {!isAuthorized && (
            <Card className="border-emerald-200 bg-gradient-to-r from-emerald-50 via-teal-50 to-green-50 shadow-sm overflow-hidden animate-in fade-in duration-200">
              <CardContent className="p-5 flex flex-col sm:flex-row items-center justify-between gap-4">
                <div className="flex items-center gap-3.5 text-center sm:text-left">
                  <div className="w-10 h-10 rounded-full bg-emerald-100 border border-emerald-300 flex items-center justify-center flex-shrink-0 text-emerald-800 shadow-inner">
                    <Lock className="w-5 h-5" />
                  </div>
                  <div>
                    <h4 className="text-sm font-bold text-emerald-950">
                      Please log in to get a personalized view of these UBI programs.
                    </h4>
                    <p className="text-xs text-emerald-700 mt-0.5">
                      Sign in or create an account to unlock tailored eligibility matching, best-fit ranking, and advanced filter facets.
                    </p>
                  </div>
                </div>
                <Link to="/login?view=signup&redirectTo=/Programs" className="flex-shrink-0">
                  <Button size="sm" className="bg-emerald-700 hover:bg-emerald-800 text-white font-semibold text-xs px-4">
                    Sign In / Register &rarr;
                  </Button>
                </Link>
              </CardContent>
            </Card>
          )}

          {/* Condition 2: Authorized Users With Incomplete Profile */}
          {isAuthorized && !hasCompletedProfile && (
            <Card className="border-emerald-200 bg-gradient-to-r from-emerald-50 via-teal-50 to-green-50 shadow-sm overflow-hidden animate-in fade-in duration-200">
              <CardContent className="p-5 flex flex-col sm:flex-row items-center justify-between gap-4">
                <div className="flex items-center gap-3.5 text-center sm:text-left">
                  <div className="w-10 h-10 rounded-full bg-emerald-100 border border-emerald-300 flex items-center justify-center flex-shrink-0 text-emerald-800 shadow-inner">
                    <Lock className="w-5 h-5" />
                  </div>
                  <div>
                    <h4 className="text-sm font-bold text-emerald-950">
                      Fill out our form for a personalized view of your eligible UBI programs.
                    </h4>
                    <p className="text-xs text-emerald-700 mt-0.5">
                      Tell us your location, household size, and income to calculate exact matches and rank programs by fit.
                    </p>
                  </div>
                </div>
                <Link to="/My-Report" className="flex-shrink-0">
                  <Button size="sm" className="bg-emerald-700 hover:bg-emerald-800 text-white font-semibold text-xs px-4">
                    Fill Out Eligibility Form &rarr;
                  </Button>
                </Link>
              </CardContent>
            </Card>
          )}

          {/* Condition 3: Authorized Users With Completed Profile (Link to Personalized View) */}
          {isAuthorized && hasCompletedProfile && (
            <Card className="border-emerald-200 bg-emerald-50/70 shadow-sm overflow-hidden animate-in fade-in duration-200">
              <CardContent className="p-4 flex flex-col sm:flex-row items-center justify-between gap-3">
                <div className="flex items-center gap-3 text-center sm:text-left">
                  <div className="w-9 h-9 rounded-full bg-emerald-100 border border-emerald-300 flex items-center justify-center flex-shrink-0 text-emerald-800">
                    <CheckCircle2 className="w-5 h-5 text-emerald-700" />
                  </div>
                  <div>
                    <h4 className="text-sm font-bold text-emerald-950">
                      Profile Active: Showing Programs Ranked by Best Fit for You
                    </h4>
                    <p className="text-xs text-emerald-700 mt-0.5">
                      Programs matching your location and demographic answers are prioritized at the top.
                    </p>
                  </div>
                </div>
                <Link to="/My-Report" className="flex-shrink-0">
                  <Button size="sm" variant="outline" className="border-emerald-600 text-emerald-800 hover:bg-emerald-100 text-xs font-semibold">
                    View Personalized Report &rarr;
                  </Button>
                </Link>
              </CardContent>
            </Card>
          )}

          {/* Main Content Area: Map View vs Card View vs Table View */}
          {viewMode === "map" ? (
            <Card className="shadow-lg border-green-100 bg-white/95 overflow-hidden">
              <CardHeader className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 pb-4">
                <div>
                  <CardTitle className="text-2xl text-green-950 font-bold flex items-center gap-2">
                    <MapIcon className="w-5 h-5 text-green-700" />
                    Interactive Program Explorer
                  </CardTitle>
                  <CardDescription className="text-sm text-gray-500 mt-1">
                    Showing <span className="font-semibold text-green-800">{sortedPrograms.length}</span> mapped initiatives across the globe. Click any marker for instant payout details.
                  </CardDescription>
                </div>
              </CardHeader>
              <CardContent className="p-0 sm:p-6 sm:pt-0">
                <ProgramsMap programs={sortedPrograms} />
              </CardContent>
            </Card>
          ) : viewMode === "table" ? (
            <Card className="shadow-lg border-green-100 bg-white/95 overflow-hidden">
              <CardHeader className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4">
                <div>
                  <CardTitle className="text-2xl text-green-950 font-bold flex items-center gap-2">
                    <TableIcon className="w-5 h-5 text-green-700" />
                    Programs Directory Table
                  </CardTitle>
                  <CardDescription className="text-sm text-gray-500 mt-1">
                    Showing <span className="font-semibold text-green-800">{sortedPrograms.length}</span> of {programs.length} programs in a condensed row view. Click any column header to sort.
                  </CardDescription>
                </div>

                {/* Search control */}
                <div className="flex items-center gap-3">
                  <div className="relative w-full sm:w-64">
                    <Search className="w-4 h-4 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" />
                    <Input
                      type="text"
                      placeholder="Search by name, org, or city..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-9 text-xs h-9 bg-gray-50/50"
                    />
                  </div>
                </div>
              </CardHeader>

              <CardContent className="p-0">
                {loading ? (
                  <div className="p-6 space-y-3">
                    {[1, 2, 3, 4, 5].map((i) => (
                      <div key={i} className="h-12 bg-gray-50 rounded-lg animate-pulse" />
                    ))}
                  </div>
                ) : sortedPrograms.length === 0 ? (
                  <div className="text-center py-16 px-4">
                    <FileCheck className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                    <h3 className="text-lg font-bold text-green-900 mb-2">No programs found</h3>
                    <p className="text-sm text-gray-500 max-w-md mx-auto mb-6">
                      No programs matched your current filter criteria. Try selecting another status pill or resetting your search.
                    </p>
                    <Button 
                      variant="outline"
                      onClick={clearAllFilters}
                      className="border-green-600 text-green-700 hover:bg-green-50"
                    >
                      Reset All Filters
                    </Button>
                  </div>
                ) : (
                  <div className="overflow-x-auto">
                    <table className="w-full text-left border-collapse text-xs">
                      <thead>
                        <tr className="bg-gray-50/80 border-y border-gray-200">
                          {/* Favorite Star header */}
                          <th className="w-10 px-3 py-3 text-center">
                            <span className="sr-only">Favorite</span>
                          </th>

                          {/* Program Name & Org */}
                          <th 
                            onClick={() => handleTableSort('name')}
                            className="px-4 py-3 text-xs font-bold text-gray-700 cursor-pointer select-none hover:bg-gray-100 transition-colors uppercase tracking-wider min-w-[240px]"
                          >
                            <div className="flex items-center gap-1.5">
                              <span>Program & Organization</span>
                              {tableSortColumn === 'name' ? (
                                tableSortDirection === 'asc' ? <ArrowUp className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" /> : <ArrowDown className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" />
                              ) : (
                                <ArrowUpDown className="w-3 h-3 text-gray-400 opacity-60" />
                              )}
                            </div>
                          </th>

                          {/* Origin / Source */}
                          <th 
                            onClick={() => handleTableSort('source')}
                            className="px-3 py-3 text-xs font-bold text-gray-700 cursor-pointer select-none hover:bg-gray-100 transition-colors uppercase tracking-wider min-w-[130px]"
                          >
                            <div className="flex items-center gap-1.5">
                              <span>Source</span>
                              {tableSortColumn === 'source' ? (
                                tableSortDirection === 'asc' ? <ArrowUp className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" /> : <ArrowDown className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" />
                              ) : (
                                <ArrowUpDown className="w-3 h-3 text-gray-400 opacity-60" />
                              )}
                            </div>
                          </th>

                          {/* Location */}
                          <th 
                            onClick={() => handleTableSort('location')}
                            className="px-3 py-3 text-xs font-bold text-gray-700 cursor-pointer select-none hover:bg-gray-100 transition-colors uppercase tracking-wider min-w-[150px]"
                          >
                            <div className="flex items-center gap-1.5">
                              <span>Location</span>
                              {tableSortColumn === 'location' ? (
                                tableSortDirection === 'asc' ? <ArrowUp className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" /> : <ArrowDown className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" />
                              ) : (
                                <ArrowUpDown className="w-3 h-3 text-gray-400 opacity-60" />
                              )}
                            </div>
                          </th>

                          {/* Monthly Payout */}
                          <th 
                            onClick={() => handleTableSort('amount')}
                            className="px-3 py-3 text-xs font-bold text-gray-700 cursor-pointer select-none hover:bg-gray-100 transition-colors uppercase tracking-wider text-right min-w-[120px]"
                          >
                            <div className="flex items-center justify-end gap-1.5">
                              <span>Payout</span>
                              {tableSortColumn === 'amount' ? (
                                tableSortDirection === 'asc' ? <ArrowUp className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" /> : <ArrowDown className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" />
                              ) : (
                                <ArrowUpDown className="w-3 h-3 text-gray-400 opacity-60" />
                              )}
                            </div>
                          </th>

                          {/* Status */}
                          <th 
                            onClick={() => handleTableSort('status')}
                            className="px-3 py-3 text-xs font-bold text-gray-700 cursor-pointer select-none hover:bg-gray-100 transition-colors uppercase tracking-wider min-w-[140px]"
                          >
                            <div className="flex items-center gap-1.5">
                              <span>Status</span>
                              {tableSortColumn === 'status' ? (
                                tableSortDirection === 'asc' ? <ArrowUp className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" /> : <ArrowDown className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" />
                              ) : (
                                <ArrowUpDown className="w-3 h-3 text-gray-400 opacity-60" />
                              )}
                            </div>
                          </th>

                          {/* Targeting */}
                          <th className="px-3 py-3 text-xs font-bold text-gray-700 uppercase tracking-wider min-w-[160px]">
                            Eligibility / Focus
                          </th>

                          {/* Match Score (if active profile) */}
                          {hasCompletedProfile && (
                            <th 
                              onClick={() => handleTableSort('matchScore')}
                              className="px-3 py-3 text-xs font-bold text-gray-700 cursor-pointer select-none hover:bg-gray-100 transition-colors uppercase tracking-wider text-center min-w-[100px]"
                            >
                              <div className="flex items-center justify-center gap-1.5">
                                <span>Fit Score</span>
                                {tableSortColumn === 'matchScore' ? (
                                  tableSortDirection === 'asc' ? <ArrowUp className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" /> : <ArrowDown className="w-3.5 h-3.5 text-green-700 stroke-[2.5]" />
                                ) : (
                                  <ArrowUpDown className="w-3 h-3 text-gray-400 opacity-60" />
                                )}
                              </div>
                            </th>
                          )}

                          {/* Actions */}
                          <th className="px-4 py-3 text-xs font-bold text-gray-700 uppercase tracking-wider text-right min-w-[110px]">
                            Action
                          </th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-gray-100 bg-white">
                        {sortedPrograms.map((program) => {
                          const isFavorite = favoritePrograms.includes(program.program_id);
                          const isStanford = program.data_source === "stanford_basic_income_lab" || !!program.stanford_experiment_id;
                          const isOpen = matchesProgramStatus(program, "accepting_applications");
                          const isPlanned = matchesProgramStatus(program, "planned");
                          const isClosedOngoing = matchesProgramStatus(program, "closed_ongoing");
                          
                          const locationText = program.municipalities?.[0]
                            ? `${program.municipalities[0]}${program.required_states?.[0] ? `, ${program.required_states[0]}` : program.available_regions?.[0] ? `, ${program.available_regions[0]}` : ''}`
                            : (program.required_states?.[0] || program.available_regions?.[0] || "Global");

                          return (
                            <tr 
                              key={program.program_id || program.id}
                              className="hover:bg-green-50/40 transition-colors group"
                            >
                              {/* Favorite Star */}
                              <td className="px-3 py-3 text-center">
                                <button
                                  type="button"
                                  onClick={() => toggleFavorite(program.program_id)}
                                  className="text-gray-300 hover:text-amber-500 transition-colors cursor-pointer"
                                  title={isFavorite ? "Remove from favorites" : "Save to favorites"}
                                >
                                  <Star className={`w-4 h-4 ${isFavorite ? "fill-amber-400 text-amber-500" : ""}`} />
                                </button>
                              </td>

                              {/* Name & Org */}
                              <td className="px-4 py-3">
                                <Link 
                                  to={`/program-details?id=${program.program_id}`}
                                  className="font-bold text-gray-900 group-hover:text-green-800 transition-colors block text-xs leading-snug line-clamp-1"
                                  title={program.name}
                                >
                                  {program.name}
                                </Link>
                                <span className="text-[11px] text-gray-500 block truncate max-w-[260px] mt-0.5">
                                  {program.organization}
                                </span>
                              </td>

                              {/* Source */}
                              <td className="px-3 py-3">
                                <div className="flex items-center gap-1 flex-wrap">
                                  {isStanford ? (
                                    <Badge className="bg-red-50 text-red-800 border-red-200 text-[10px] font-semibold py-0 px-1.5 shadow-2xs">
                                      <GraduationCap className="w-2.5 h-2.5 mr-1 text-red-600" />
                                      Stanford
                                    </Badge>
                                  ) : (
                                    <Badge className="bg-emerald-50 text-emerald-800 border-emerald-200 text-[10px] font-semibold py-0 px-1.5 shadow-2xs">
                                      <Globe className="w-2.5 h-2.5 mr-1 text-emerald-600" />
                                      Community
                                    </Badge>
                                  )}
                                  {program.is_rct && (
                                    <Badge className="bg-purple-50 text-purple-800 border-purple-200 text-[10px] font-semibold py-0 px-1.5 shadow-2xs">
                                      RCT
                                    </Badge>
                                  )}
                                </div>
                              </td>

                              {/* Location */}
                              <td className="px-3 py-3">
                                <div className="flex items-center gap-1 text-xs text-gray-700">
                                  <MapPin className="w-3 h-3 text-gray-400 flex-shrink-0" />
                                  <span className="truncate max-w-[140px]" title={locationText}>
                                    {locationText}
                                  </span>
                                </div>
                              </td>

                              {/* Payout Amount */}
                              <td className="px-3 py-3 text-right">
                                <span className="font-extrabold text-xs text-green-950 block">
                                  {program.monthly_amount_usd ? `$${Number(program.monthly_amount_usd).toLocaleString()}` : 'Variable'}
                                </span>
                                <span className="text-[10px] text-gray-500 block truncate max-w-[100px] ml-auto">
                                  {program.amount_description || '/ mo'}
                                </span>
                              </td>

                              {/* Status */}
                              <td className="px-3 py-3">
                                {isOpen ? (
                                  <Badge className="bg-emerald-100 text-emerald-900 border-emerald-200 text-[10px] font-semibold py-0 px-1.5">
                                    Open, ongoing
                                  </Badge>
                                ) : isPlanned ? (
                                  <Badge className="bg-blue-100 text-blue-900 border-blue-200 text-[10px] font-semibold py-0 px-1.5">
                                    Planned
                                  </Badge>
                                ) : isClosedOngoing ? (
                                  <Badge className="bg-purple-100 text-purple-900 border-purple-200 text-[10px] font-semibold py-0 px-1.5">
                                    Closed, ongoing
                                  </Badge>
                                ) : (
                                  <Badge className="bg-gray-100 text-gray-700 border-gray-200 text-[10px] font-medium py-0 px-1.5">
                                    Closed, historical
                                  </Badge>
                                )}
                              </td>

                              {/* Eligibility / Focus */}
                              <td className="px-3 py-3">
                                <div className="flex flex-wrap gap-1">
                                  {program.gender_requirement && (
                                    <span className="text-[10px] px-1.5 py-0.5 bg-pink-50 text-pink-700 rounded font-medium border border-pink-200">
                                      {program.gender_requirement === 'female' ? 'Women' : program.gender_requirement}
                                    </span>
                                  )}
                                  {(program.min_age || program.max_age) && (
                                    <span className="text-[10px] px-1.5 py-0.5 bg-blue-50 text-blue-700 rounded font-medium border border-blue-200">
                                      {program.min_age && program.max_age ? `Age ${program.min_age}-${program.max_age}` : program.min_age ? `Age ${program.min_age}+` : `Under ${program.max_age}`}
                                    </span>
                                  )}
                                  {program.max_household_income_usd && (
                                    <span className="text-[10px] px-1.5 py-0.5 bg-amber-50 text-amber-700 rounded font-medium border border-amber-200">
                                      &lt; ${(program.max_household_income_usd / 1000).toFixed(0)}k
                                    </span>
                                  )}
                                  {!program.gender_requirement && !program.min_age && !program.max_age && !program.max_household_income_usd && (
                                    <span className="text-[10px] text-gray-400">
                                      {program.targeting_details ? program.targeting_details.substring(0, 30) + '...' : 'Universal / Regional'}
                                    </span>
                                  )}
                                </div>
                              </td>

                              {/* Fit Score */}
                              {hasCompletedProfile && (
                                <td className="px-3 py-3 text-center">
                                  {program.matchScore !== undefined ? (
                                    <span className={`inline-block px-2 py-0.5 rounded-full text-[11px] font-bold ${
                                      program.matchScore >= 80 ? "bg-emerald-100 text-emerald-900 border border-emerald-300" :
                                      program.matchScore >= 50 ? "bg-amber-100 text-amber-900 border border-amber-300" :
                                      "bg-gray-100 text-gray-700 border border-gray-200"
                                    }`}>
                                      {program.matchScore}%
                                    </span>
                                  ) : (
                                    <span className="text-gray-300">—</span>
                                  )}
                                </td>
                              )}

                              {/* Action Buttons */}
                              <td className="px-4 py-3 text-right">
                                <div className="flex items-center justify-end gap-1.5">
                                  {(program.website || program.apply_url) && (
                                    <button
                                      type="button"
                                      onClick={() => window.open(program.apply_url || program.website, '_blank')}
                                      className="p-1 text-gray-400 hover:text-green-800 transition-colors cursor-pointer"
                                      title="Open Official Website / Portal"
                                    >
                                      <ExternalLink className="w-3.5 h-3.5" />
                                    </button>
                                  )}
                                  <Link to={`/program-details?id=${program.program_id}`}>
                                    <Button
                                      size="sm"
                                      variant="outline"
                                      className="border-green-700 text-green-700 hover:bg-green-50 text-[11px] h-7 px-2 font-semibold cursor-pointer"
                                    >
                                      Details &rarr;
                                    </Button>
                                  </Link>
                                </div>
                              </td>
                            </tr>
                          );
                        })}
                      </tbody>
                    </table>
                  </div>
                )}
              </CardContent>
            </Card>
          ) : (
            <Card className="shadow-lg border-green-100 bg-white/95">
              <CardHeader className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-4">
                <div>
                  <CardTitle className="text-2xl text-green-950 font-bold">Available Programs</CardTitle>
                  <CardDescription className="text-sm text-gray-500 mt-1">
                    Showing <span className="font-semibold text-green-800">{sortedPrograms.length}</span> of {programs.length} verified programs
                    {hasCompletedProfile && (
                      <span className="text-emerald-700 font-medium ml-1">
                        • Ranked by Best Fit
                      </span>
                    )}
                  </CardDescription>
                </div>

                {/* Search and Sort controls */}
                <div className="flex flex-wrap items-center gap-3">
                  <div className="relative w-full sm:w-64">
                    <Search className="w-4 h-4 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" />
                    <Input
                      type="text"
                      placeholder="Search by name, org, or city..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-9 text-xs h-9 bg-gray-50/50"
                    />
                  </div>

                  <div className="w-full sm:w-48">
                    <Select value={sortField} onValueChange={setSortField}>
                      <SelectTrigger className="text-xs h-9 bg-white">
                        <SelectValue placeholder="Sort order" />
                      </SelectTrigger>
                      <SelectContent>
                        {hasCompletedProfile && (
                          <SelectItem value="best_fit">⭐ Best Fit for Me</SelectItem>
                        )}
                        <SelectItem value="name">Alphabetical (A-Z)</SelectItem>
                        <SelectItem value="amount">Monthly Value ($)</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
              </CardHeader>
              
              <CardContent>
                {loading ? (
                  <div className="space-y-4">
                    {[1, 2, 3].map((i) => (
                      <div key={i} className="h-32 bg-gray-50 rounded-xl animate-pulse" />
                    ))}
                  </div>
                ) : sortedPrograms.length === 0 ? (
                  <div className="text-center py-16 px-4">
                    <FileCheck className="w-12 h-12 text-gray-300 mx-auto mb-3" />
                    <h3 className="text-lg font-bold text-green-900 mb-2">No programs found</h3>
                    <p className="text-sm text-gray-500 max-w-md mx-auto mb-6">
                      No programs matched your current filter criteria. Try selecting another status pill or resetting your search.
                    </p>
                    <Button 
                      variant="outline"
                      onClick={clearAllFilters}
                      className="border-green-600 text-green-700 hover:bg-green-50"
                    >
                      Reset All Filters
                    </Button>
                  </div>
                ) : (
                  <ProgramList 
                    programs={sortedPrograms}
                    filters={{
                      status: filterMode === "quick" ? quickFilter : "all",
                      ...advancedFilters
                    }}
                    favoritePrograms={favoritePrograms}
                    onToggleFavorite={toggleFavorite}
                    userEmail={user?.email}
                    isAdmin={user?.role === 'admin' || user?.role === 'owner'}
                    onClearFilters={clearAllFilters}
                  />
                )}
              </CardContent>
            </Card>
          )}

        </div>
      </div>

      {/* Volunteer Community Support Encouragement Modal (1-time gentle notice) */}
      <DonationEncouragementModal
        isOpen={supporterEncouragementOpen}
        onClose={() => setSupporterEncouragementOpen(false)}
        user={user}
      />

      {/* Volunteer Community Supporter Gate (Interactive Map Access) */}
      <SupporterGateModal
        isOpen={supporterGated}
        user={user}
        featureName="the global interactive map"
      />
    </>
  );
}
