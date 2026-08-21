import { Toaster } from "@/components/ui/toaster"
import { QueryClientProvider } from '@tanstack/react-query'
import { queryClientInstance } from '@/lib/query-client'
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import PageNotFound from './lib/PageNotFound';
import { AuthProvider, useAuth } from '@/lib/AuthContext';
import UserNotRegisteredError from '@/components/UserNotRegisteredError';
import ScrollToTop from './components/ScrollToTop';
import Home from './pages/Home';
import Dashboard from './pages/Dashboard';
import Profile from './pages/Profile';
import EditProfile from './pages/EditProfile';
import About from './pages/About';
import Programs from './pages/Programs';
import Blog from './pages/Blog';
import BlogPost from './pages/BlogPost';
import SubmitProgram from './pages/SubmitProgram';
import SubmitProgramPage from './pages/Submit-Program';
import ManageProgramPage from './pages/Manage-Program';
import MyProgramsPage from './pages/My-Programs';
import ProgramDetailsPage from './pages/program-details';
import Terms from './pages/Terms';
import Privacy from './pages/Privacy';
import CookiePolicy from './pages/Cookie-Policy';
import Disclaimer from './pages/Disclaimer';
import Accessibility from './pages/Accessibility';
import Community from './pages/Community';
import Login from './pages/Login';
import MyReport from './pages/MyReport';
import GoodDollarClaim from './pages/claim/GoodDollarClaim';
import FundLoopClaim from './pages/claim/FundLoopClaim';
import CirclesClaim from './pages/claim/CirclesClaim';
import ServicesPage from './pages/Services';
import EcosystemPage from './pages/Ecosystem';
import Header from './components/Header';
import Footer from './components/Footer';
import PrototypeDisclaimer from './components/PrototypeDisclaimer';
// Add page imports here

import ProtectedRoute from './components/ProtectedRoute';

const AuthenticatedApp = () => {
  const { isLoadingAuth, authError, navigateToLogin } = useAuth();

  // Show loading spinner while checking app public settings or auth
  if (isLoadingAuth) {
    return (
      <div className="fixed inset-0 flex items-center justify-center">
        <div className="w-8 h-8 border-4 border-slate-200 border-t-slate-800 rounded-full animate-spin"></div>
      </div>
    );
  }

  // Handle authentication errors
  if (authError) {
    if (authError.type === 'auth_required') {
      // Redirect to login automatically
      navigateToLogin();
      return null;
    }
  }

  // Render the main app
  return (
    <Routes>
      {/* Public Routes */}
      <Route path="/login" element={<Login />} />
      <Route path="/Login" element={<Login />} />
      <Route path="/" element={<Home />} />
      <Route path="/Home" element={<Home />} />
      <Route path="/home" element={<Home />} />
      <Route path="/About" element={<About />} />
      <Route path="/about" element={<About />} />
      <Route path="/Programs" element={<Programs />} />
      <Route path="/programs" element={<Programs />} />
      <Route path="/Blog" element={<Blog />} />
      <Route path="/blog" element={<Blog />} />
      <Route path="/BlogPost" element={<BlogPost />} />
      <Route path="/blogpost" element={<BlogPost />} />
      <Route path="/program-details" element={<ProgramDetailsPage />} />
      <Route path="/Terms" element={<Terms />} />
      <Route path="/terms" element={<Terms />} />
      <Route path="/Privacy" element={<Privacy />} />
      <Route path="/privacy" element={<Privacy />} />
      <Route path="/Cookie-Policy" element={<CookiePolicy />} />
      <Route path="/cookie-policy" element={<CookiePolicy />} />
      <Route path="/Disclaimer" element={<Disclaimer />} />
      <Route path="/disclaimer" element={<Disclaimer />} />
      <Route path="/Accessibility" element={<Accessibility />} />
      <Route path="/accessibility" element={<Accessibility />} />
      <Route path="/Community" element={<Community />} />
      <Route path="/community" element={<Community />} />
      <Route path="/My-Report" element={<MyReport />} />
      <Route path="/my-report" element={<MyReport />} />
      <Route path="/report" element={<MyReport />} />
      <Route path="/claim/gooddollar" element={<GoodDollarClaim />} />
      <Route path="/claim/fundloop" element={<FundLoopClaim />} />
      <Route path="/claim/circles" element={<CirclesClaim />} />
      <Route path="/Services" element={<ServicesPage />} />
      <Route path="/services" element={<ServicesPage />} />
      <Route path="/Ecosystem" element={<EcosystemPage />} />
      <Route path="/ecosystem" element={<EcosystemPage />} />

      {/* Authenticated-Only Protected Routes */}
      <Route element={<ProtectedRoute />}>
        <Route path="/Dashboard" element={<Dashboard />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/My-Programs" element={<MyProgramsPage />} />
        <Route path="/my-programs" element={<MyProgramsPage />} />
        <Route path="/Profile" element={<Profile />} />
        <Route path="/profile" element={<Profile />} />
        <Route path="/EditProfile" element={<EditProfile />} />
        <Route path="/editprofile" element={<EditProfile />} />
        <Route path="/Manage-Program" element={<ManageProgramPage />} />
        <Route path="/manage-program" element={<ManageProgramPage />} />
        <Route path="/SubmitProgram" element={<SubmitProgramPage />} />
        <Route path="/submitprogram" element={<SubmitProgramPage />} />
        <Route path="/Submit-Program" element={<SubmitProgramPage />} />
        <Route path="/submit-program" element={<SubmitProgramPage />} />
      </Route>

      {/* 404 Catch-All */}
      <Route path="*" element={<PageNotFound />} />
    </Routes>
  );
};


function App() {

  return (
    <AuthProvider>
      <QueryClientProvider client={queryClientInstance}>
        <Router>
          <ScrollToTop />
          <Header />
          <div className="pt-16 min-h-[calc(100vh-64px)] flex flex-col">
            <div className="flex-grow">
              <AuthenticatedApp />
            </div>
            <Footer />
          </div>
          <PrototypeDisclaimer />
        </Router>
        <Toaster />
      </QueryClientProvider>
    </AuthProvider>
  )
}

export default App

