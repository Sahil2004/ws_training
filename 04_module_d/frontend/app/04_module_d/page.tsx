import { BASE_URL } from "../config";

export default function Landing() {
  return (
    <main className="bg-gray-200">
      <header className="flex z-20 justify-between px-20 py-5 items-center fixed w-screen backdrop-blur-2xl bg-[#ffffffaf]">
        <img src="images/logo.svg" alt="Logo" className="h-10" />
        <nav className="flex gap-4">
          <a href="">Regional Guide</a>
          <a href="">Experiences</a>
          <a href="">Practical Information</a>
          <a href="">Essential Information</a>
          <a href="">Contact</a>
        </nav>
      </header>
      <section className="relative">
        <span className="bg-[#00000057] z-5 w-full h-full absolute"></span>
        <picture>
          <source
            media="(width < 760px)"
            srcSet="images/taiwan-cover-low-res.jpg"
          />
          <source media="(width >= 760px)" srcSet="images/taiwan-cover.jpg" />
          <img
            src="images/taiwan-cover.jpg"
            alt="Taiwan Background Cover"
            className="h-[90vh] w-full object-cover"
          />
        </picture>
        <span className="absolute flex flex-col items-start gap-4 bottom-10 left-10 z-10 text-white">
          <h1 className="font-black text-5xl">
            Taiwan: Small Island, Big Adventures
          </h1>
          <p>
            From marble gorges to neon nights—discover four regions, countless
            experiences.
          </p>
          <a href="#regions" className="px-6 py-4 bg-green-400 rounded-xl">
            Explore Regions -&gt;
          </a>
        </span>
      </section>
      <section className="w-full flex flex-col py-20 items-center gap-10" id="regions">
        <span className="w-3/4">
          <h2 className="font-bold text-3xl">Regional Guide</h2>
          <p className="text-gray-600 pt-5">
          Click a region on the map to explore.
          </p>
        </span>
        <span className="flex gap-5">
        <article className="border border-gray-200 shadow-xl rounded-xl bg-white p-20 relative">
            <span className="block absolute bg-green-500/40 rounded-xl top-20 left-20 w-3/4 h-30"></span>
            <span className="block absolute bg-blue-500/40 rounded-xl top-50 left-20 w-1/3 h-30"></span>
            <span className="block absolute bg-amber-500/40 rounded-xl top-80 left-20 w-1/3 h-30"></span>
            <span className="block absolute bg-pink-300/40 rounded-xl top-50 left-60 w-50 h-60"></span>
            <img src="images/taiwan-map.svg" alt="Taiwan Map" className="w-80" />
        </article>
        </span>
      </section>
      <section className="w-full flex flex-col py-20 items-center gap-10">
        <span className="w-3/4">
          <h2 className="font-bold text-3xl">Essential Information</h2>
          <p className="text-gray-600 pt-5">
            Official support and key contacts for your trip to Taiwan.
          </p>
        </span>
        <span className="flex gap-10 flex-wrap justify-between w-3/4">
          <article className="border border-gray-100 shadow-xl p-4 rounded-xl bg-white">
            <h3 className="font-bold text-xl">Taiwan Tourism Bureau</h3>
            <ul>
              <li>+886-2-0000-0000</li>
              <li>info@example.com</li>
              <li>example.com</li>
            </ul>
            <span className="flex gap-2">
              <button className="bg-black text-white py-2 px-4 rounded-xl">
                Read aloud
              </button>
              <button className="border bg-white py-2 px-4 rounded-xl">
                Stop
              </button>
            </span>
          </article>
          <article className="border border-gray-100 shadow-xl p-4 rounded-xl bg-white">
            <h3 className="font-bold text-xl">Official Website QR</h3>
            <span className="flex">
              <span className="flex flex-col gap-2">
                Scan to visit the official tourism website.
                <a href="#" className="text-green-500">
                  Open site --&gt;
                </a>
              </span>
            </span>
          </article>
          <article className="border border-gray-100 shadow-xl p-4 rounded-xl bg-white">
            <h3 className="font-bold text-xl">Emergency & Safety Contacts</h3>
            <ul>
              <li>
                <b>Police:</b> 000
              </li>
              <li>
                <b>Fire/Ambulance:</b> 000
              </li>
              <li>
                <b>Tourist Hotline:</b> 0800-000-000
              </li>
            </ul>
          </article>
        </span>
        <article className="flex flex-col gap-5 items-center w-3/4 border border-gray-100 shadow-xl p-4 py-8 rounded-xl bg-white">
          <h3 className="font-bold text-xl">Downloadable Travel Guide</h3>
          <p className="text-gray-600">
            Comprehensive PDF guide with maps, itineraries, and essential tips
            for your Taiwan adventure.
          </p>
          <a
            href="pdf/taiwan-travel-guide.pdf"
            download={true}
            className="px-6 py-4 bg-green-400 rounded-xl"
          >
            -&gt; Download Travel Guide (PDF)
          </a>
        </article>
      </section>
      <section className="w-full flex flex-col py-30 items-center">
        <span className="w-1/2">
          <h2 className="font-bold text-3xl">Travel Consultation</h2>
          <p className="text-gray-600 py-5">
            Get personalized recommendations for your Taiwan adventure.
          </p>
        </span>
        <form
          method="POST"
          action={BASE_URL + "/contact"}
          className="border border-gray-100 rounded-xl p-4 w-1/2 flex flex-col gap-4 bg-white shadow-xl"
        >
          <span className="flex gap-2">
            <label
              htmlFor="name"
              className="font-bold flex flex-col gap-2 w-full"
            >
              Name:
              <input
                type="text"
                name="name"
                id="name"
                className="border border-gray-300 p-2 rounded-xl font-normal w-full"
                placeholder="Your full name"
                required={true}
              />
            </label>
            <label
              htmlFor="email"
              className="font-bold flex flex-col gap-2 w-full"
            >
              Email:
              <input
                type="email"
                name="email"
                id="email"
                className="border border-gray-300 p-2 rounded-xl font-normal w-full"
                placeholder="you@example.com"
                required={true}
              />
            </label>
          </span>
          <span className="flex gap-2">
            <label
              htmlFor="country"
              className="font-bold flex flex-col gap-2 w-full"
            >
              Country:
              <input
                type="text"
                name="country"
                id="country"
                className="border border-gray-300 p-2 rounded-xl font-normal w-full"
                placeholder="Where are you based?"
                required={true}
              />
            </label>
            <label
              htmlFor="email"
              className="font-bold flex flex-col gap-2 w-full"
            >
              Interests:
              <input
                type="text"
                name="interests"
                id="interests"
                className="border border-gray-300 p-2 rounded-xl font-normal w-full"
                placeholder="Culture, food, nature, beaches…"
                required={true}
              />
            </label>
          </span>
          <label
            htmlFor="message"
            className="font-bold flex flex-col gap-2 w-full"
          >
            Message:
            <textarea
              name="message"
              id="message"
              className="border border-gray-300 p-2 rounded-xl font-normal w-full"
              rows={5}
              placeholder="Tell us about your dream Taiwan trip!"
            ></textarea>
          </label>
          <input
            type="submit"
            value="Submit"
            className="border-2 bg-green-500 text-white rounded-xl px-4 py-2 self-end border-black"
          />
        </form>
      </section>
      <footer className="flex flex-col justify-between items-center w-full">
        <section className="flex justify-between px-20 py-5 items-center w-full">
          <img src="images/logo.svg" alt="Logo" className="h-10" />
          <nav className="flex gap-4">
            <a href="https://facebook.com">
              <img
                src="icons/icon-facebook.svg"
                alt="Facebook"
                className="h-5"
              />
            </a>
            <a href="https://instagram.com">
              <img
                src="icons/icon-instagram.svg"
                alt="Instagram"
                className="h-5"
              />
            </a>
            <a href="https://youtube.com">
              <img src="icons/icon-youtube.svg" alt="Youtube" className="h-5" />
            </a>
          </nav>
        </section>
        <span className="w-full px-20">
          <hr className="w-full border-gray-400" />
        </span>
        <section className="flex justify-between w-full px-20 pb-10 pt-5 text-gray-600">
          <p>© 2026 Taiwan Explorer</p>
          <nav className="flex gap-4">
            <a href="#">Privacy Policy</a>
            <a href="#">Terms and Conditions</a>
          </nav>
        </section>
      </footer>
    </main>
  );
}
