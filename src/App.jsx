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
import ServicesPage from './pages/Services';
import EcosystemPage from './pages/Ecosystem';
import Header from './components/Header';
import Footer from './components/Footer';
// Add page imports here

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
      <Route path="/login" element={<Login />} />
      <Route path="/Login" element={<Login />} />
      <Route path="/" element={<Home />} />
      <Route path="/Home" element={<Home />} />
      <Route path="/Dashboard" element={<Dashboard />} />
      <Route path="/Profile" element={<Profile />} />
      <Route path="/EditProfile" element={<EditProfile />} />
      <Route path="/About" element={<About />} />
      <Route path="/Programs" element={<Programs />} />
      <Route path="/Blog" element={<Blog />} />
      <Route path="/BlogPost" element={<BlogPost />} />
      <Route path="/SubmitProgram" element={<SubmitProgram />} />
      <Route path="/Submit-Program" element={<SubmitProgramPage />} />
      <Route path="/Manage-Program" element={<ManageProgramPage />} />
      <Route path="/My-Programs" element={<MyProgramsPage />} />
      <Route path="/program-details" element={<ProgramDetailsPage />} />
      <Route path="/Terms" element={<Terms />} />
      <Route path="/Privacy" element={<Privacy />} />
      <Route path="/Cookie-Policy" element={<CookiePolicy />} />
      <Route path="/Disclaimer" element={<Disclaimer />} />
      <Route path="/Accessibility" element={<Accessibility />} />
      <Route path="/Community" element={<Community />} />
      <Route path="/Services" element={<ServicesPage />} />
      <Route path="/Ecosystem" element={<EcosystemPage />} />
      {/* Add your page Route elements here */}
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
        </Router>
        <Toaster />
      </QueryClientProvider>
    </AuthProvider>
  )
}

export default App

