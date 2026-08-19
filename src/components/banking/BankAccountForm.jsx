
import React, { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Loader2 } from "lucide-react";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

const COUNTRIES = [
  "United States",
  "Canada",
  "United Kingdom",
  "Australia",
  "New Zealand",
  "Germany",
  "France",
  "Spain",
  "Italy",
  "Japan",
  "South Korea",
  "Sweden",
  "Ireland",
];

export default function BankAccountForm({ 
  open, 
  onClose, 
  onSubmit, 
  userCountry, 
  userFullName,
  loading = false,
  initialData = null,
  isEditing = false
}) {
  const [formData, setFormData] = useState(initialData || {
    bank_name: "",
    account_number: "",
    routing_number: "",
    iban: "",
    swift_code: "",
    country: userCountry || "",
    account_holder_name: userFullName || "",
    is_primary: false
  });

  // Reset form when initialData changes
  useEffect(() => {
    if (initialData) {
      setFormData(initialData);
    }
  }, [initialData]);

  const handleChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData);
  };

  const showRoutingNumber = formData.country === "United States";
  const showIBAN = !showRoutingNumber;
  const showSWIFT = !showRoutingNumber;

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>{isEditing ? 'Edit Bank Account' : 'Add Bank Account'}</DialogTitle>
          <DialogDescription>
            {isEditing ? 'Update your bank account details' : 'Enter your bank account details for receiving UBI payments'}
          </DialogDescription>
        </DialogHeader>
        <form onSubmit={handleSubmit}>
          <div className="grid gap-4 py-4">
            <div>
              <Label htmlFor="bank_name">Bank Name</Label>
              <Input
                id="bank_name"
                value={formData.bank_name}
                onChange={(e) => handleChange("bank_name", e.target.value)}
                required
              />
            </div>
            
            <div>
              <Label htmlFor="country">Country</Label>
              <Select
                value={formData.country}
                onValueChange={(value) => handleChange("country", value)}
                required
              >
                <SelectTrigger>
                  <SelectValue placeholder="Select country" />
                </SelectTrigger>
                <SelectContent>
                  {COUNTRIES.map(country => (
                    <SelectItem key={country} value={country}>
                      {country}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            
            <div>
              <Label htmlFor="account_holder_name">Account Holder Name</Label>
              <Input
                id="account_holder_name"
                value={formData.account_holder_name}
                onChange={(e) => handleChange("account_holder_name", e.target.value)}
                required
              />
            </div>
            
            <div>
              <Label htmlFor="account_number">Account Number</Label>
              <Input
                id="account_number"
                value={formData.account_number}
                onChange={(e) => handleChange("account_number", e.target.value)}
                required
              />
            </div>
            
            {showRoutingNumber && (
              <div>
                <Label htmlFor="routing_number">Routing Number</Label>
                <Input
                  id="routing_number"
                  value={formData.routing_number}
                  onChange={(e) => handleChange("routing_number", e.target.value)}
                />
              </div>
            )}
            
            {showIBAN && (
              <div>
                <Label htmlFor="iban">IBAN (International Bank Account Number)</Label>
                <Input
                  id="iban"
                  value={formData.iban}
                  onChange={(e) => handleChange("iban", e.target.value)}
                />
              </div>
            )}
            
            {showSWIFT && (
              <div>
                <Label htmlFor="swift_code">SWIFT/BIC Code</Label>
                <Input
                  id="swift_code"
                  value={formData.swift_code}
                  onChange={(e) => handleChange("swift_code", e.target.value)}
                />
              </div>
            )}
            
            <div className="flex items-center justify-between pt-2">
              <div className="space-y-0.5">
                <Label>Set as Primary Account</Label>
                <p className="text-sm text-gray-500">
                  Use this account for all UBI payments
                </p>
              </div>
              <Switch
                checked={formData.is_primary}
                onCheckedChange={(checked) => handleChange("is_primary", checked)}
              />
            </div>
          </div>
          <DialogFooter>
            <Button
              type="button"
              variant="outline"
              onClick={onClose}
            >
              Cancel
            </Button>
            <Button 
              type="submit"
              className="bg-green-700 hover:bg-green-800"
              disabled={loading}
            >
              {loading ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Saving...
                </>
              ) : (
                isEditing ? "Update Account" : "Save Account"
              )}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}

