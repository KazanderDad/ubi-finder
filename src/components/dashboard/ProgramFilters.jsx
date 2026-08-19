
import React from "react";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Label } from "@/components/ui/label";

export default function ProgramFilters({ filters, setFilters }) {
  const countries = ["all", "united states", "canada", "united kingdom", "germany", "brazil", "kenya"];
  const states = ["all", "california", "new york", "texas", "florida", "illinois"];

  return (
    <div className="space-y-4">
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div>
          <Label className="text-green-700">Country</Label>
          <Select
            value={filters.country}
            onValueChange={(value) => setFilters({ ...filters, country: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Select country" />
            </SelectTrigger>
            <SelectContent>
              {countries.map(country => (
                <SelectItem key={country} value={country}>
                  {country === "all" ? "All Countries" : 
                    country.charAt(0).toUpperCase() + country.slice(1)}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        {filters.country === "united states" && (
          <div>
            <Label className="text-green-700">State</Label>
            <Select
              value={filters.state}
              onValueChange={(value) => setFilters({ ...filters, state: value })}
            >
              <SelectTrigger>
                <SelectValue placeholder="Select state" />
              </SelectTrigger>
              <SelectContent>
                {states.map(state => (
                  <SelectItem key={state} value={state}>
                    {state === "all" ? "All States" : 
                      state.charAt(0).toUpperCase() + state.slice(1)}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
        )}

        <div>
          <Label className="text-green-700">Status</Label>
          <Select
            value={filters.status}
            onValueChange={(value) => setFilters({ ...filters, status: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Select status" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Programs</SelectItem>
              <SelectItem value="upcoming">Coming Soon</SelectItem>
              <SelectItem value="active">Active Programs</SelectItem>
              <SelectItem value="closed">Closed for Applications</SelectItem>
            </SelectContent>
          </Select>
        </div>

        <div>
          <Label className="text-green-700">Payment Type</Label>
          <Select
            value={filters.paymentType}
            onValueChange={(value) => setFilters({ ...filters, paymentType: value })}
          >
            <SelectTrigger>
              <SelectValue placeholder="Select payment type" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All Types</SelectItem>
              <SelectItem value="standard">Standard Only</SelectItem>
              <SelectItem value="digital">Digital Only</SelectItem>
              <SelectItem value="both">Both Available</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>
    </div>
  );
}

