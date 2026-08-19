import React, { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Card, CardContent } from "@/components/ui/card";
import { Sparkles, ArrowRight, ArrowLeft, CheckCircle2, MapPin, Building, CreditCard, Coins, Smartphone } from "lucide-react";
import { supabase } from "@/lib/supabaseClient";

// Country to currency mapping
const COUNTRY_CURRENCY = {
  "United States": "USD", "Canada": "CAD", "United Kingdom": "GBP",
  "Australia": "AUD", "New Zealand": "NZD", "Germany": "EUR",
  "France": "EUR", "Spain": "EUR", "Italy": "EUR", "Japan": "JPY",
  "South Korea": "KRW", "Sweden": "SEK", "Ireland": "EUR"
};

const getCurrencyForCountry = (country) => COUNTRY_CURRENCY[country] || "USD";

const COUNTRIES = [
  "United States", "Canada", "United Kingdom", "Australia", "New Zealand",
  "Germany", "France", "Spain", "Italy", "Japan", "South Korea", "Sweden", "Ireland",
];

const US_STATES = [
  "Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut",
  "Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa",
  "Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan",
  "Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire",
  "New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio",
  "Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota",
  "Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia",
  "Wisconsin","Wyoming","District of Columbia"
];

const CANADIAN_PROVINCES = [
  "Alberta","British Columbia","Manitoba","New Brunswick","Newfoundland and Labrador",
  "Northwest Territories","Nova Scotia","Nunavut","Ontario","Prince Edward Island",
  "Quebec","Saskatchewan","Yukon"
];

// Capability 1: Hierarchical municipal pilots mapping
const MUNICIPAL_PILOTS = {
  "California": ["Stockton", "San Francisco", "Compton", "Los Angeles", "Other / Not listed"],
  "New Brunswick": ["Moncton", "Saint John", "Fredericton", "Other / Not listed"],
  "Ontario": ["Thunder Bay", "Hamilton", "Lindsay", "Other / Not listed"],
  "Alaska": ["Anchorage", "Fairbanks", "Juneau", "Statewide / Other"],
};

const WHY_TOOLTIP = "Many programs are geared towards women. We do our utmost to keep your information safe, but you should only disclose if you are comfortable doing so. We only use this information to show you programs applicable to you. It's always your decision if you then apply to them or not.";

function WhyTooltip() {
  const [show, setShow] = useState(false);
  return (
    <div className="relative ml-auto">
      <span
        className="text-xs text-gray-400 underline cursor-help whitespace-nowrap"
        onMouseEnter={() => setShow(true)}
        onMouseLeave={() => setShow(false)}
        onFocus={() => setShow(true)}
        onBlur={() => setShow(false)}
        tabIndex={0}
      >
        why do we ask?
      </span>
      {show && (
        <div className="absolute right-0 top-5 z-50 w-72 bg-gray-900 text-white text-xs rounded-lg p-3 shadow-xl leading-relaxed">
          {WHY_TOOLTIP}
          <div className="absolute -top-1.5 right-3 w-3 h-3 bg-gray-900 rotate-45" />
        </div>
      )}
    </div>
  );
}

export default function UserForm({ onSubmit }) {
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    country: "",
    state: "",
    municipality: "",
    accepts_digital_currency: true,
    household_size: 1,
    income_range: "",
    accepts_foreign_currency: true,
    gender: "",
    women_count: "",
    currency: "USD",
  });

  const [matchingCount, setMatchingCount] = useState(null);
  const [loadingCount, setLoadingCount] = useState(false);

  const [email, setEmail] = useState("");
  const [sending, setSending] = useState(false);
  const [sent, setSent] = useState(false);
  const [sendError, setSendError] = useState("");

  const needsState = ["United States", "Canada"].includes(formData.country);
  const stateOptions = formData.country === "United States" ? US_STATES : CANADIAN_PROVINCES;
  const municipalOptions = MUNICIPAL_PILOTS[formData.state] || null;
  const isMultiPerson = formData.household_size > 1;

  // 2b: Inline program count preview query
  useEffect(() => {
    if (!formData.country) {
      setMatchingCount(null);
      return;
    }
    const fetchCount = async () => {
      setLoadingCount(true);
      try {
        const { data, error } = await supabase
          .from('programs')
          .select('id, available_regions, required_states, municipalities');
        if (!error && data) {
          const matching = data.filter(p => {
            const regions = p.available_regions || [];
            const states = p.required_states || [];
            const countryMatch = regions.length === 0 || regions.includes(formData.country) || regions.includes("Global") || regions.includes("Worldwide");
            if (!countryMatch) return false;
            
            if (formData.state && states.length > 0 && !states.includes(formData.state)) {
              return false;
            }
            return true;
          });
          setMatchingCount(matching.length || data.length);
        }
      } catch (err) {
        console.error("Count fetch error:", err);
      } finally {
        setLoadingCount(false);
      }
    };
    fetchCount();
  }, [formData.country, formData.state, formData.municipality]);

  // Step 1 validation
  const isStep1Valid = formData.country !== "" && (!needsState || formData.state !== "");

  // Step 2 validation
  const genderSatisfied = isMultiPerson
    ? formData.women_count !== ""
    : formData.gender !== "";
  const isStep2Valid = formData.income_range !== "" && genderSatisfied;

  // Step 3 validation
  const isStep3Valid = email.trim() !== "";

  const handleChange = (field, value) => {
    setFormData(prev => {
      const newData = { ...prev, [field]: value };
      if (field === "country" && value) {
        newData.currency = getCurrencyForCountry(value);
        newData.state = "";
        newData.municipality = "";
      }
      if (field === "state") {
        newData.municipality = "";
      }
      if (field === "household_size") {
        newData.gender = "";
        newData.women_count = "";
      }
      return newData;
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!isStep1Valid || !isStep2Valid || !isStep3Valid) return;

    localStorage.setItem("pendingProfile", JSON.stringify(formData));

    setSending(true);
    setSendError("");
    try {
      const { error } = await supabase.auth.signInWithOtp({
        email: email.trim(),
        options: {
          emailRedirectTo: `${window.location.origin}/Programs`,
        },
      });
      if (error) throw error;
      setSent(true);
      if (onSubmit) onSubmit({ ...formData, email: email.trim() });
    } catch (err) {
      setSendError(err.message || "Something went wrong. Please try again.");
    } finally {
      setSending(false);
    }
  };

  if (sent) {
    return (
      <Card className="shadow-lg border-green-100 bg-white/95">
        <CardContent className="p-8 text-center space-y-4">
          <div className="w-16 h-16 bg-green-100 text-green-700 rounded-full flex items-center justify-center mx-auto text-2xl shadow-inner">
            📬
          </div>
          <h3 className="text-2xl font-bold text-green-950">Almost There!</h3>
          <p className="text-gray-600 text-sm max-w-md mx-auto leading-relaxed">
            We've sent a magic login link to <span className="font-semibold text-green-800">{email}</span>. Please click the link in your inbox to verify your email and instantly access your personalized report.
          </p>
          <div className="pt-2 text-xs text-gray-400">
            Did not receive it? Check your spam folder or try again.
          </div>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="shadow-xl border-green-100 bg-white/95">
      <CardContent className="p-6 md:p-8">
        {/* 2a. Multi-step Progress Bar */}
        <div className="mb-8">
          <div className="flex items-center justify-between text-xs font-semibold text-gray-500 mb-2">
            <span className={step >= 1 ? "text-green-700 font-bold" : ""}>1. Location & Region</span>
            <span className={step >= 2 ? "text-green-700 font-bold" : ""}>2. Household & Income</span>
            <span className={step >= 3 ? "text-green-700 font-bold" : ""}>3. Delivery Rails</span>
          </div>
          <div className="w-full bg-gray-200 h-2 rounded-full overflow-hidden">
            <div 
              className="bg-green-600 h-full transition-all duration-300 rounded-full"
              style={{ width: `${(step / 3) * 100}%` }}
            />
          </div>
        </div>

        <form onSubmit={handleSubmit} className="space-y-6">
          {/* STEP 1: Location & Regional Sub-questions */}
          {step === 1 && (
            <div className="space-y-5 animate-in fade-in duration-200">
              <div>
                <Label htmlFor="country" className="text-sm font-semibold text-gray-800">
                  Where do you live? <span className="text-red-500">*</span>
                </Label>
                <Select value={formData.country} onValueChange={(v) => handleChange("country", v)}>
                  <SelectTrigger className="mt-1.5"><SelectValue placeholder="Select your country" /></SelectTrigger>
                  <SelectContent>
                    {COUNTRIES.map(c => <SelectItem key={c} value={c}>{c}</SelectItem>)}
                  </SelectContent>
                </Select>
              </div>

              {needsState && (
                <div>
                  <Label htmlFor="state" className="text-sm font-semibold text-gray-800">
                    State / Province <span className="text-red-500">*</span>
                  </Label>
                  <Select value={formData.state} onValueChange={(v) => handleChange("state", v)}>
                    <SelectTrigger className="mt-1.5"><SelectValue placeholder="Select state/province" /></SelectTrigger>
                    <SelectContent>
                      {stateOptions.map(s => <SelectItem key={s} value={s}>{s}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
              )}

              {/* Capability 1: Conditional Municipal Pilot Sub-Question */}
              {municipalOptions && (
                <div className="p-4 bg-emerald-50/70 border border-emerald-200 rounded-xl space-y-2 animate-in fade-in duration-300">
                  <div className="flex items-center gap-1.5 text-xs font-bold text-emerald-900">
                    <MapPin className="w-3.5 h-3.5 text-emerald-700" />
                    Do you reside in any of these specific pilot municipalities?
                  </div>
                  <Select value={formData.municipality} onValueChange={(v) => handleChange("municipality", v)}>
                    <SelectTrigger className="bg-white mt-1">
                      <SelectValue placeholder="Select municipality (or choose Other)" />
                    </SelectTrigger>
                    <SelectContent>
                      {municipalOptions.map(m => (
                        <SelectItem key={m} value={m}>{m}</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                  <p className="text-[11px] text-emerald-700">
                    Some municipal experiments are restricted to specific city boundaries (e.g. Moncton in NB or Stockton in CA).
                  </p>
                </div>
              )}

              {/* 2b. Inline program count preview */}
              {formData.country && (
                <div className="p-3.5 bg-green-50/90 border border-green-200 rounded-xl flex items-center gap-2.5 text-xs text-green-900 animate-in fade-in">
                  <Sparkles className="w-4 h-4 text-green-700 flex-shrink-0" />
                  <span>
                    {loadingCount ? (
                      "Checking available programs..."
                    ) : matchingCount ? (
                      <>We found <strong>{matchingCount} income programs</strong> available in {formData.state ? `${formData.state}, ` : ""}{formData.country}.</>
                    ) : (
                      <>Programs found in {formData.country}.</>
                    )}
                  </span>
                </div>
              )}

              <Button
                type="button"
                disabled={!isStep1Valid}
                onClick={() => setStep(2)}
                className="w-full bg-green-700 hover:bg-green-800 text-white font-medium py-2.5 shadow-md flex items-center justify-center gap-2"
              >
                Continue to Step 2
                <ArrowRight className="w-4 h-4" />
              </Button>
            </div>
          )}

          {/* STEP 2: Household & Income */}
          {step === 2 && (
            <div className="space-y-5 animate-in fade-in duration-200">
              <div>
                <Label htmlFor="household" className="text-sm font-semibold text-gray-800">
                  Household Size <span className="text-red-500">*</span>
                </Label>
                <Select
                  value={formData.household_size.toString()}
                  onValueChange={(v) => handleChange("household_size", parseInt(v))}
                >
                  <SelectTrigger className="mt-1.5"><SelectValue placeholder="Select household size" /></SelectTrigger>
                  <SelectContent>
                    {[1,2,3,4,5,6,7,8].map(n => (
                      <SelectItem key={n} value={n.toString()}>{n} {n === 1 ? "person" : "people"}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              {!isMultiPerson ? (
                <div>
                  <div className="flex items-center justify-between mb-1.5">
                    <Label htmlFor="gender" className="text-sm font-semibold text-gray-800">
                      Gender <span className="text-red-500">*</span>
                    </Label>
                    <WhyTooltip />
                  </div>
                  <Select value={formData.gender} onValueChange={(v) => handleChange("gender", v)}>
                    <SelectTrigger><SelectValue placeholder="Select gender" /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="female">Female</SelectItem>
                      <SelectItem value="male">Male</SelectItem>
                      <SelectItem value="abstain">Prefer not to disclose</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              ) : (
                <div>
                  <div className="flex items-center justify-between mb-1.5">
                    <Label htmlFor="women_count" className="text-sm font-semibold text-gray-800">
                      How many in your household are girls / women? <span className="text-red-500">*</span>
                    </Label>
                    <WhyTooltip />
                  </div>
                  <Select value={formData.women_count} onValueChange={(v) => handleChange("women_count", v)}>
                    <SelectTrigger><SelectValue placeholder="Select number" /></SelectTrigger>
                    <SelectContent>
                      {Array.from({ length: formData.household_size + 1 }, (_, i) => i).map(n => (
                        <SelectItem key={n} value={n.toString()}>{n === 0 ? "None" : n}</SelectItem>
                      ))}
                      <SelectItem value="abstain">Prefer not to disclose</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              )}

              <div>
                <Label htmlFor="income" className="text-sm font-semibold text-gray-800">
                  Annual Household Income <span className="text-red-500">*</span>
                </Label>
                <Select value={formData.income_range} onValueChange={(v) => handleChange("income_range", v)}>
                  <SelectTrigger className="mt-1.5"><SelectValue placeholder="Select income range" /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="0-20k">$0 – $20,000</SelectItem>
                    <SelectItem value="20k-40k">$20,001 – $40,000</SelectItem>
                    <SelectItem value="40k-60k">$40,001 – $60,000</SelectItem>
                    <SelectItem value="60k+">$60,001+</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="flex items-center gap-3 pt-2">
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => setStep(1)}
                  className="w-1/3 border-gray-300 flex items-center justify-center gap-1.5"
                >
                  <ArrowLeft className="w-4 h-4" />
                  Back
                </Button>
                <Button
                  type="button"
                  disabled={!isStep2Valid}
                  onClick={() => setStep(3)}
                  className="w-2/3 bg-green-700 hover:bg-green-800 text-white font-medium flex items-center justify-center gap-2"
                >
                  Continue to Step 3
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </div>
            </div>
          )}

          {/* STEP 3: Delivery Rails & Email */}
          {step === 3 && (
            <div className="space-y-5 animate-in fade-in duration-200">
              <div className="p-4 bg-gray-50/80 rounded-xl space-y-4 border border-gray-100">
                <div className="text-xs font-bold uppercase tracking-wider text-gray-500 mb-1">
                  Delivery Preferences (Capability 4)
                </div>

                <div className="flex items-center justify-between">
                  <div className="space-y-0.5">
                    <Label className="text-sm font-medium text-gray-900">Accept Foreign Currency</Label>
                    <p className="text-xs text-gray-500">Willing to receive payments in non-local fiat</p>
                  </div>
                  <Switch
                    checked={formData.accepts_foreign_currency}
                    onCheckedChange={(v) => handleChange("accepts_foreign_currency", v)}
                  />
                </div>

                <div className="flex items-center justify-between pt-2 border-t border-gray-200/60">
                  <div className="space-y-0.5">
                    <Label className="text-sm font-medium text-gray-900">Accept Crypto & Digital Wallets</Label>
                    <p className="text-xs text-gray-500">Include Web3 daily claim protocols (e.g. GoodDollar, Circles)</p>
                  </div>
                  <Switch
                    checked={formData.accepts_digital_currency}
                    onCheckedChange={(v) => handleChange("accepts_digital_currency", v)}
                  />
                </div>
              </div>

              <div>
                <Label htmlFor="email" className="text-sm font-semibold text-gray-800">
                  Email Address <span className="text-red-500">*</span>
                </Label>
                <Input
                  id="email"
                  type="email"
                  placeholder="you@example.com"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                  className="mt-1.5"
                />
                <p className="text-xs text-gray-400 mt-1">We'll send your verified matching program report directly here.</p>
              </div>

              {sendError && (
                <p className="text-xs text-red-600 bg-red-50 p-2.5 rounded-lg border border-red-200">{sendError}</p>
              )}

              <div className="flex items-center gap-3 pt-2">
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => setStep(2)}
                  className="w-1/3 border-gray-300 flex items-center justify-center gap-1.5"
                >
                  <ArrowLeft className="w-4 h-4" />
                  Back
                </Button>
                <Button
                  type="submit"
                  disabled={!isStep3Valid || sending}
                  className="w-2/3 bg-green-700 hover:bg-green-800 text-white font-semibold py-2.5 shadow-md flex items-center justify-center gap-2 disabled:opacity-50"
                >
                  {sending ? "Sending Link..." : "Find Available Programs"}
                </Button>
              </div>
            </div>
          )}
        </form>
      </CardContent>
    </Card>
  );
}
