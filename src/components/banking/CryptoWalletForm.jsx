
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
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { AlertCircle } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";

const BLOCKCHAINS = [
  { value: "ethereum", label: "Ethereum (ETH)" },
  { value: "bitcoin", label: "Bitcoin (BTC)" },
  { value: "solana", label: "Solana (SOL)" },
  { value: "polygon", label: "Polygon (MATIC)" },
  { value: "avalanche", label: "Avalanche (AVAX)" },
  { value: "binance_smart_chain", label: "BNB Chain (BNB)" },
  { value: "other", label: "Other" }
];

export default function CryptoWalletForm({ 
  open, 
  onClose, 
  onSubmit, 
  loading = false,
  initialData = null,
  isEditing = false
}) {
  const [activeTab, setActiveTab] = useState("manual");
  const [formData, setFormData] = useState(initialData || {
    blockchain: "",
    other_blockchain: "",
    public_key: "",
    wallet_name: "",
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

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>{isEditing ? 'Edit Crypto Wallet' : 'Add Crypto Wallet'}</DialogTitle>
          <DialogDescription>
            {isEditing ? 'Update your wallet details' : 'Connect your wallet or enter details manually'}
          </DialogDescription>
        </DialogHeader>

        <Tabs defaultValue="manual" className="w-full" onValueChange={setActiveTab}>
          <TabsList className="grid w-full grid-cols-3">
            <TabsTrigger value="connect">Connect Wallet</TabsTrigger>
            <TabsTrigger value="create">New Account</TabsTrigger>
            <TabsTrigger value="manual">Manual Entry</TabsTrigger>
          </TabsList>
          
          <TabsContent value="connect" className="mt-4">
            <Alert>
              <AlertCircle className="h-4 w-4" />
              <AlertTitle>Wallet Connection Coming Soon</AlertTitle>
              <AlertDescription>
                Direct wallet connection via RainbowKit will be available soon. For now, please add your wallet address manually.
              </AlertDescription>
            </Alert>
          </TabsContent>
          
          <TabsContent value="create" className="mt-4">
            <Alert>
              <AlertCircle className="h-4 w-4" />
              <AlertTitle>Account Creation Coming Soon</AlertTitle>
              <AlertDescription>
                Create new wallet accounts via Privy will be available soon. For now, please add your existing wallet address manually.
              </AlertDescription>
            </Alert>
          </TabsContent>
          
          <TabsContent value="manual" className="mt-4">
            <form onSubmit={handleSubmit}>
              <div className="grid gap-4 py-4">
                <div>
                  <Label htmlFor="wallet_name">Wallet Name (Optional)</Label>
                  <Input
                    id="wallet_name"
                    placeholder="e.g., My ETH Wallet"
                    value={formData.wallet_name}
                    onChange={(e) => handleChange("wallet_name", e.target.value)}
                  />
                </div>
                
                <div>
                  <Label htmlFor="blockchain">Blockchain</Label>
                  <Select
                    value={formData.blockchain}
                    onValueChange={(value) => handleChange("blockchain", value)}
                    required
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Select blockchain" />
                    </SelectTrigger>
                    <SelectContent>
                      {BLOCKCHAINS.map(chain => (
                        <SelectItem key={chain.value} value={chain.value}>
                          {chain.label}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                
                {formData.blockchain === "other" && (
                  <div>
                    <Label htmlFor="other_blockchain">Specify Blockchain</Label>
                    <Input
                      id="other_blockchain"
                      placeholder="e.g., Cardano, Polkadot"
                      value={formData.other_blockchain}
                      onChange={(e) => handleChange("other_blockchain", e.target.value)}
                      required={formData.blockchain === "other"}
                    />
                  </div>
                )}
                
                <div>
                  <Label htmlFor="public_key">Wallet Address</Label>
                  <Input
                    id="public_key"
                    placeholder="Your public wallet address"
                    value={formData.public_key}
                    onChange={(e) => handleChange("public_key", e.target.value)}
                    required
                  />
                </div>
                
                <div className="flex items-center justify-between pt-2">
                  <div className="space-y-0.5">
                    <Label>Set as Primary Wallet</Label>
                    <p className="text-sm text-gray-500">
                      Use this wallet for all UBI crypto payments
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
                    isEditing ? "Update Wallet" : "Save Wallet"
                  )}
                </Button>
              </DialogFooter>
            </form>
          </TabsContent>
        </Tabs>
      </DialogContent>
    </Dialog>
  );
}

