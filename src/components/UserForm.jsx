
import React, { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Card, CardContent } from "@/components/ui/card";
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
  const [formData, setFormData] = useState({
    country: "",
    state: "",
    accepts_digital_currency: true,
    household_size: 1,
    income_range: "",
    accepts_foreign_currency: true,
    gender: "",
    women_count: "",
    currency: "USD",
  });

  const [email, setEmail] = useState("");
  const [sending, setSending] = useState(false);
  const [sent, setSent] = useState(false);
  const [sendError, setSendError] = useState("");

  const needsState = ["United States", "Canada"].includes(formData.country);
  const stateOptions = formData.country === "United States" ? US_STATES : CANADIAN_PROVINCES;
  const isMultiPerson = formData.household_size > 1;

  const genderSatisfied = isMultiPerson
    ? formData.women_count !== ""
    : formData.gender !== "";

  const isFormValid =
    formData.country !== "" &&
    (!needsState || formData.state !== "") &&
    formData.income_range !== "" &&
    genderSatisfied &&
    email.trim() !== "";

  const handleChange = (field, value) => {
    setFormData(prev => {
      const newData = { ...prev, [field]: value };
      if (field === "country" && value) {
        newData.currency = getCurrencyForCountry(value);
        newData.state = "";
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
    if (!isFormValid) return;

    // Save profile data to localStorage so it's available after magic link login
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
      <Card className="shadow-lg">
        <CardContent className="p-8 text-center space-y-3">
          <div className="text-4xl">📬</div>
          <h3 className="text-lg font-semibold text-green-900">Thanks!</h3>
          <p className="text-gray-600 text-sm leading-relaxed">
            We've sent you an email. Please click the link there to verify your email and access your report.
          </p>
        </CardContent>
      </Card>
    );
  }

  return (
    <Card className="shadow-lg">
      <CardContent className="p-6">
        <form onSubmit={handleSubmit} className="space-y-6">

          {/* Country */}
          <div>
            <Label htmlFor="country">Country <span className="text-red-500">*</span></Label>
            <Select value={formData.country} onValueChange={(v) => handleChange("country", v)}>
              <SelectTrigger><SelectValue placeholder="Select country" /></SelectTrigger>
              <SelectContent>
                {COUNTRIES.map(c => <SelectItem key={c} value={c}>{c}</SelectItem>)}
              </SelectContent>
            </Select>
          </div>

          {/* State / Province */}
          {needsState && (
            <div>
              <Label htmlFor="state">State/Province <span className="text-red-500">*</span></Label>
              <Select value={formData.state} onValueChange={(v) => handleChange("state", v)}>
                <SelectTrigger><SelectValue placeholder="Select state/province" /></SelectTrigger>
                <SelectContent>
                  {stateOptions.map(s => <SelectItem key={s} value={s}>{s}</SelectItem>)}
                </SelectContent>
              </Select>
            </div>
          )}

          {/* Household Size */}
          <div>
            <Label htmlFor="household">Household Size <span className="text-red-500">*</span></Label>
            <Select
              value={formData.household_size.toString()}
              onValueChange={(v) => handleChange("household_size", parseInt(v))}
            >
              <SelectTrigger><SelectValue placeholder="Select household size" /></SelectTrigger>
              <SelectContent>
                {[1,2,3,4,5,6,7,8].map(n => (
                  <SelectItem key={n} value={n.toString()}>{n} {n === 1 ? "person" : "people"}</SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          {/* Gender (single) or Women count (multi) */}
          {!isMultiPerson ? (
            <div>
              <div className="flex items-center justify-between mb-1">
                <Label htmlFor="gender">Gender <span className="text-red-500">*</span></Label>
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
              <div className="flex items-center justify-between mb-1">
                <Label htmlFor="women_count">How many in your household are girls / women? <span className="text-red-500">*</span></Label>
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

          {/* Annual Income */}
          <div>
            <Label htmlFor="income">Annual Household Income <span className="text-red-500">*</span></Label>
            <Select value={formData.income_range} onValueChange={(v) => handleChange("income_range", v)}>
              <SelectTrigger><SelectValue placeholder="Select income range" /></SelectTrigger>
              <SelectContent>
                <SelectItem value="0-20k">$0 – $20,000</SelectItem>
                <SelectItem value="20k-40k">$20,001 – $40,000</SelectItem>
                <SelectItem value="40k-60k">$40,001 – $60,000</SelectItem>
                <SelectItem value="60k+">$60,001+</SelectItem>
              </SelectContent>
            </Select>
          </div>

          {/* Toggles */}
          <div className="flex items-center justify-between">
            <div className="space-y-0.5">
              <Label>Accept Foreign Currency</Label>
              <p className="text-sm text-gray-500">Willing to receive payments in foreign currencies</p>
            </div>
            <Switch
              checked={formData.accepts_foreign_currency}
              onCheckedChange={(v) => handleChange("accepts_foreign_currency", v)}
            />
          </div>

          <div className="flex items-center justify-between">
            <div className="space-y-0.5">
              <Label>Accept Digital Currency</Label>
              <p className="text-sm text-gray-500">Willing to receive digital payments (crypto)</p>
            </div>
            <Switch
              checked={formData.accepts_digital_currency}
              onCheckedChange={(v) => handleChange("accepts_digital_currency", v)}
            />
          </div>

          {/* Email */}
          <div>
            <Label htmlFor="email">Email Address <span className="text-red-500">*</span></Label>
            <Input
              id="email"
              type="email"
              placeholder="you@example.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
            <p className="text-xs text-gray-400 mt-1">We'll send your personalised program report to this address.</p>
          </div>

          {sendError && (
            <p className="text-sm text-red-600">{sendError}</p>
          )}

          <Button
            type="submit"
            disabled={!isFormValid || sending}
            className="w-full bg-blue-600 hover:bg-blue-700 disabled:opacity-40 disabled:cursor-not-allowed"
          >
            {sending ? "Sending…" : "Find Available Programs"}
          </Button>
        </form>
      </CardContent>
    </Card>
  );
}
