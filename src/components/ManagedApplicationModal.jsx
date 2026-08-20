import React, { useState, useEffect } from "react";
import { supabase } from "@/lib/supabaseClient";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import { Badge } from "@/components/ui/badge";
import { 
  ShieldCheck, 
  CheckCircle2, 
  AlertCircle, 
  FileText, 
  Lock, 
  ArrowRight, 
  ArrowLeft,
  Sparkles,
  Printer,
  Copy,
  Check
} from "lucide-react";

export default function ManagedApplicationModal({ 
  isOpen, 
  onClose, 
  program, 
  user, 
  userProfile, 
  onSuccess 
}) {
  const [step, setStep] = useState(1); // 1: Missing Fields, 2: Review & Consent, 3: Success Confirmation
  const [formData, setFormData] = useState({
    fullName: "",
    email: "",
    phone: "",
    address: "",
    municipality: "",
    stateProvince: "",
    country: "",
    incomeRange: "",
    payoutRail: "",
    dob: "",
    agreedConsent: false
  });

  const [submitting, setSubmitting] = useState(false);
  const [submittedApp, setSubmittedApp] = useState(null);
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    if (isOpen) {
      setStep(1);
      setFormData({
        fullName: userProfile?.full_name || userProfile?.name || "",
        email: user?.email || userProfile?.email || "",
        phone: userProfile?.phone || "",
        address: userProfile?.address || "",
        municipality: userProfile?.municipality || "",
        stateProvince: userProfile?.state || userProfile?.state_province || "",
        country: userProfile?.country || "United States",
        incomeRange: userProfile?.income_range || "0-20k",
        payoutRail: program?.payout_rail || "direct_deposit",
        dob: userProfile?.date_of_birth || "",
        agreedConsent: false
      });
    }
  }, [isOpen, userProfile, user, program]);

  if (!program) return null;

  const handleInputChange = (field, value) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const isStep1Valid = formData.fullName.trim() && formData.email.trim() && formData.country.trim();

  const handleSubmitApplication = async () => {
    if (!formData.agreedConsent || !user?.id) return;

    setSubmitting(true);
    try {
      const refCode = `UBI-APP-${new Date().getFullYear()}-${Math.random().toString(36).substring(2, 7).toUpperCase()}`;
      const consentText = `I authorize UBI Finder to submit my basic income qualification application to ${program.organization} on my behalf. I certify that all submitted information is accurate and agree to electronic signature terms.`;

      const payload = {
        applicant: {
          full_name: formData.fullName,
          email: formData.email,
          phone: formData.phone || "N/A",
          address: formData.address || "N/A",
          municipality: formData.municipality || "N/A",
          state_province: formData.stateProvince || "N/A",
          country: formData.country,
          income_tier: formData.incomeRange,
          payout_rail_preference: formData.payoutRail,
          date_of_birth: formData.dob || "N/A"
        },
        program: {
          program_id: program.program_id,
          name: program.name,
          organization: program.organization,
          monthly_amount_usd: program.monthly_amount_usd,
          currency: program.currency
        },
        metadata: {
          ip_origin: "verified_web_client",
          submission_version: "v2.1"
        }
      };

      const { data, error } = await supabase
        .from("managed_applications")
        .insert([{
          user_id: user.id,
          program_id: program.program_id,
          reference_code: refCode,
          submitted_payload: payload,
          consent_captured: true,
          consent_text: consentText,
          consent_timestamp: new Date().toISOString(),
          status: "submitted",
          status_message: "Application successfully submitted and securely queued for partner program intake.",
          confirmation_receipt: {
            receipt_id: refCode,
            disbursement_channel: formData.payoutRail,
            estimated_decision_days: 14
          }
        }])
        .select()
        .single();

      if (error) throw error;

      // Also create a user notification
      await supabase.from("user_notifications").insert([{
        user_id: user.id,
        type: "managed_application_submitted",
        title: "Managed Application Submitted",
        message: `Your application for ${program.name} was submitted. Reference: ${refCode}`,
        program_id: program.program_id,
        program_name: program.name,
        severity: "success",
        action_url: `/program-details`
      }]);

      setSubmittedApp(data);
      setStep(3);
      if (onSuccess) onSuccess(data);
    } catch (err) {
      console.error("Error submitting managed application:", err);
      alert("Error submitting application. Please try again.");
    } finally {
      setSubmitting(false);
    }
  };

  const copyRefCode = () => {
    if (submittedApp?.reference_code) {
      navigator.clipboard.writeText(submittedApp.reference_code);
      setCopied(true);
      setTimeout(() => setCopied(false), 2000);
    }
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <div className="flex items-center gap-2 mb-1">
            <span className="p-1.5 bg-emerald-100 text-emerald-800 rounded-lg">
              <ShieldCheck className="w-4 h-4" />
            </span>
            <Badge className="bg-emerald-100 text-emerald-900 border-emerald-300 text-[10px] font-bold">
              Managed Application Service
            </Badge>
          </div>
          <DialogTitle className="text-xl font-bold text-gray-900">
            Apply for {program.name}
          </DialogTitle>
          <DialogDescription className="text-xs text-gray-500">
            UBI Finder prepares, authorizes, and submits your application directly to the program operators.
          </DialogDescription>
        </DialogHeader>

        {/* STEP 1: Verify & Complete Data */}
        {step === 1 && (
          <div className="space-y-4 py-2 animate-in fade-in">
            <div className="p-3.5 bg-emerald-50/70 border border-emerald-200 rounded-xl text-xs text-emerald-900 flex items-start gap-2">
              <Sparkles className="w-4 h-4 text-emerald-700 flex-shrink-0 mt-0.5" />
              <span>
                Please ensure your contact and demographic details are accurate. We will format and submit these directly to <strong>{program.organization}</strong>.
              </span>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
              <div className="space-y-1">
                <Label className="text-xs font-semibold text-gray-700">Legal Full Name *</Label>
                <Input
                  value={formData.fullName}
                  onChange={(e) => handleInputChange("fullName", e.target.value)}
                  placeholder="Full legal name"
                  className="text-xs"
                />
              </div>

              <div className="space-y-1">
                <Label className="text-xs font-semibold text-gray-700">Contact Email *</Label>
                <Input
                  value={formData.email}
                  onChange={(e) => handleInputChange("email", e.target.value)}
                  placeholder="Email address"
                  className="text-xs"
                />
              </div>

              <div className="space-y-1">
                <Label className="text-xs font-semibold text-gray-700">Phone Number (Optional)</Label>
                <Input
                  value={formData.phone}
                  onChange={(e) => handleInputChange("phone", e.target.value)}
                  placeholder="+1 (555) 000-0000"
                  className="text-xs"
                />
              </div>

              <div className="space-y-1">
                <Label className="text-xs font-semibold text-gray-700">Date of Birth</Label>
                <Input
                  type="date"
                  value={formData.dob}
                  onChange={(e) => handleInputChange("dob", e.target.value)}
                  className="text-xs"
                />
              </div>

              <div className="space-y-1 sm:col-span-2">
                <Label className="text-xs font-semibold text-gray-700">Street / Residential Address</Label>
                <Input
                  value={formData.address}
                  onChange={(e) => handleInputChange("address", e.target.value)}
                  placeholder="123 Main Street, Apt 4B"
                  className="text-xs"
                />
              </div>

              <div className="space-y-1">
                <Label className="text-xs font-semibold text-gray-700">Municipality / City</Label>
                <Input
                  value={formData.municipality}
                  onChange={(e) => handleInputChange("municipality", e.target.value)}
                  placeholder="e.g. Stockton or Moncton"
                  className="text-xs"
                />
              </div>

              <div className="space-y-1">
                <Label className="text-xs font-semibold text-gray-700">State / Province</Label>
                <Input
                  value={formData.stateProvince}
                  onChange={(e) => handleInputChange("stateProvince", e.target.value)}
                  placeholder="State or Province"
                  className="text-xs"
                />
              </div>
            </div>

            <DialogFooter className="pt-4 border-t border-gray-100 flex items-center justify-between">
              <Button variant="ghost" size="sm" onClick={onClose} className="text-xs text-gray-500">
                Cancel
              </Button>
              <Button 
                size="sm" 
                disabled={!isStep1Valid} 
                onClick={() => setStep(2)}
                className="bg-green-700 hover:bg-green-800 text-white font-bold text-xs"
              >
                Review & Authorize &rarr;
              </Button>
            </DialogFooter>
          </div>
        )}

        {/* STEP 2: Review Submission & Capture Consent */}
        {step === 2 && (
          <div className="space-y-4 py-2 animate-in fade-in">
            <div className="p-3.5 bg-gray-50 border border-gray-200 rounded-xl space-y-2 text-xs">
              <span className="font-bold text-gray-900 block text-sm">Submission Data Summary</span>
              <div className="grid grid-cols-2 gap-2 text-gray-700">
                <div><strong>Applicant:</strong> {formData.fullName}</div>
                <div><strong>Email:</strong> {formData.email}</div>
                <div><strong>Phone:</strong> {formData.phone || "Not provided"}</div>
                <div><strong>Location:</strong> {formData.municipality || "City"}, {formData.stateProvince || ""}, {formData.country}</div>
                <div><strong>Income Tier:</strong> {formData.incomeRange}</div>
                <div><strong>Delivery Rail:</strong> {formData.payoutRail}</div>
              </div>
            </div>

            {/* Explicit Consent Authorization */}
            <div className="p-4 bg-emerald-50/90 border-2 border-emerald-300 rounded-xl space-y-3">
              <div className="flex items-start gap-3">
                <Checkbox
                  id="consent"
                  checked={formData.agreedConsent}
                  onCheckedChange={(checked) => handleInputChange("agreedConsent", !!checked)}
                  className="mt-0.5"
                />
                <label htmlFor="consent" className="text-xs text-emerald-950 leading-relaxed cursor-pointer select-none">
                  <strong className="block mb-0.5">Authorization & Legal Consent</strong>
                  I hereby authorize <strong>UBI Finder</strong> to submit this Universal Basic Income qualification application on my behalf to <strong>{program.organization}</strong>. I certify that the submitted demographic and residence information is true and accurate.
                </label>
              </div>
            </div>

            <DialogFooter className="pt-4 border-t border-gray-100 flex items-center justify-between">
              <Button variant="outline" size="sm" onClick={() => setStep(1)} className="text-xs">
                &larr; Back to Edit
              </Button>
              <Button
                size="sm"
                disabled={!formData.agreedConsent || submitting}
                onClick={handleSubmitApplication}
                className="bg-emerald-800 hover:bg-emerald-900 text-white font-bold text-xs shadow-md"
              >
                {submitting ? "Submitting Application..." : "Submit Managed Application"}
              </Button>
            </DialogFooter>
          </div>
        )}

        {/* STEP 3: Success Confirmation & Proof Receipt */}
        {step === 3 && submittedApp && (
          <div className="space-y-5 py-4 text-center animate-in zoom-in-95 duration-200">
            <div className="w-16 h-16 bg-emerald-100 text-emerald-700 rounded-full flex items-center justify-center mx-auto text-2xl shadow-inner border border-emerald-200">
              <CheckCircle2 className="w-8 h-8 text-emerald-600" />
            </div>

            <div className="space-y-1">
              <h3 className="text-2xl font-black text-emerald-950">Application Submitted!</h3>
              <p className="text-xs text-gray-600 max-w-md mx-auto">
                Your application for <strong>{program.name}</strong> was submitted on your behalf.
              </p>
            </div>

            {/* Proof Receipt Box */}
            <div className="p-4 bg-gray-50 rounded-2xl border border-gray-200 text-left space-y-2 text-xs">
              <div className="flex items-center justify-between border-b border-gray-200 pb-2">
                <span className="font-bold text-gray-700">Official Reference Code:</span>
                <div className="flex items-center gap-1">
                  <code className="font-mono font-bold text-emerald-800 bg-emerald-50 px-2 py-0.5 rounded border border-emerald-200">
                    {submittedApp.reference_code}
                  </code>
                  <Button size="icon" variant="ghost" className="h-6 w-6" onClick={copyRefCode}>
                    {copied ? <Check className="w-3.5 h-3.5 text-green-600" /> : <Copy className="w-3.5 h-3.5" />}
                  </Button>
                </div>
              </div>

              <div className="flex justify-between text-gray-600">
                <span>Timestamp:</span>
                <span>{new Date(submittedApp.created_at).toLocaleString()}</span>
              </div>

              <div className="flex justify-between text-gray-600">
                <span>Status:</span>
                <span className="font-semibold text-emerald-700 uppercase">{submittedApp.status}</span>
              </div>
            </div>

            <DialogFooter className="pt-4 flex items-center justify-center gap-3">
              <Button size="sm" onClick={onClose} className="bg-green-700 hover:bg-green-800 text-white font-bold text-xs">
                Done & View Status
              </Button>
            </DialogFooter>
          </div>
        )}
      </DialogContent>
    </Dialog>
  );
}
