import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import WebMDInterviewTest

internal final class WebMDInterviewTest_UnitTests: XCTestCase {
    /**
     1. Write 2 unit tests for the FeedItem model (valid decoding, invalid decoding)
     2. Write unit test for validating the filtering and sorting of the feed items.
     3. OPTIONAL: Write at least 1 unit test for a functionality you think that it needs to be covered by tests.
     */

    internal func testValidDecode() throws {
        guard let resourcePath = Bundle.main.path(forResource: "data", ofType: "json") else {
            fatalError("data not found")
        }

        let data = try Data(contentsOf: URL(fileURLWithPath: resourcePath), options: .mappedIfSafe)
        let response = try JSONDecoder().decode(FeedResponseModel.self, from: data)

        XCTAssertEqual(response, FeedResponseModel.mock)
    }

    internal func testViewModel() {
        let scheduler = TestScheduler(initialClock: 0)
        let viewModel = FeedViewModel()
        let disposeBag = DisposeBag()

        let items = scheduler.createObserver([FeedItemModel].self)

        let input = FeedViewModel.Input(didLoad: .just(()))
        let output = viewModel.transform(input: input)

        output.items
            .drive(items)
            .disposed(by: disposeBag)

        scheduler.start()
        XCTAssertEqual(
            items.events,
            [
                .next(0, FeedResponseModel.mockFilteredAndSorted.items),
                .completed(0)
            ]
        )
    }
}

extension FeedResponseModel {
    internal static var mock: Self {
        FeedResponseModel(
            items: [
                .mockBiotin,
                .mockViruses,
                .mockViruses,
                .mockSitting,
                .mockMRI,
                .mockBiotin,
                .mockGlasses
            ]
        )
    }

    internal static var mockFilteredAndSorted: Self {
        FeedResponseModel(
            items: [
                .mockBiotin,
                .mockGlasses,
                .mockSitting,
                .mockViruses,
                .mockMRI
            ]
        )
    }
}

extension FeedItemModel {
    internal static var mockBiotin: Self {
        FeedItemModel(
            title: "Biotin Can Distort Lab Tests",
            description: "The FDA is warning that high doses of vitamin B7, or biotin, in dietary supplements can interfere with hundreds of common lab tests",
            imageURL: "https://img.staging.medscape.com/pi/logos/laboratory.jpg",
            detail: "In some cases, extra biotin causes falsely high results on tests. In others, it causes the results to read as falsely low. Tzhat’s true with some ways to detect a protein called troponin, which rises after heart muscle has been damaged. Doctors use the troponin test in the emergency room to find out whether a patient’s chest pain is from heartburn or a heart attack.The FDA says a patient who was taking high levels of biotin died when a troponin test failed to show he was having a heart attack."
        )
    }

    internal static var mockViruses: Self {
        FeedItemModel(
            title: "Viruses vs Bacteria",
            description: "Viruses are tinier than bacteria. In fact, the largest virus is smaller than the smallest bacterium. All viruses have is a protein coat and a core of genetic material, either RNA or DNA.",
            imageURL: "https://img.staging.medscape.com/pi/logos/microscope.jpg",
            detail: "Unlike bacteria, viruses can't survive without a host. They can only reproduce by attaching themselves to cells. In most cases, they reprogram the cells to make new viruses until the cells burst and die. In other cases, they turn normal cells into malignant or cancerous cells.Also unlike bacteria, most viruses do cause disease, and they're quite specific about the cells they attack. For example, certain viruses attack cells in the liver, respiratory system, or blood. In some cases, viruses target bacteria. In some cases, it's difficult to determine the origin of an infection because many ailments -- including pneumonia, meningitis, and diarrhea -- can be caused by either bacteria or viruses. That said, your doctor often can pinpoint the cause by listening to your medical history and doing a physical exam. If necessary, they also can order a blood or urine test, or a 'culture test' of tissue to identify bacteria or viruses. Occasionally, a biopsy of affected tissue is ordered, as well.\nThe discovery of antibiotics for bacterial infections is considered one of the most important breakthroughs in medical history. Unfortunately, bacteria are very adaptable, and the overuse of antibiotics has made many of them resistant to antibiotics. This has created serious problems, especially in hospital settings."
        )
    }

    internal static var mockSitting: Self {
        FeedItemModel(
            title: "Sitting May Harm Health",
            description: "The studies just keep coming. Sitting our life away, it seems, may be very bad for our health and even our life expectancy.",
            imageURL: "",
            detail: "The new studies add even more weight to earlier research suggesting that too much sitting is bad -- even if you get regular exercise.  Experts say they still don't know for sure which comes first. Does too much sitting trigger poor health, or is it the other way around?"
        )
    }

    internal static var mockMRI: Self {
        FeedItemModel(
            title: "What Happens when you get an MRI",
            description: "An MRI is a test that uses powerful magnets, radio waves, and a computer to make detailed pictures inside your body.",
            imageURL: "https://img.staging.medscape.com/pi/logos/mri.jpg",
            detail: "An MRI helps a doctor diagnose a disease or injury, and it can monitor how well you’re doing with a treatment. MRIs can be done on different parts of your body."
        )
    }

    internal static var mockGlasses: Self {
        FeedItemModel(
            title: "Do I need reading glasses",
            description: "As your eyes get less flexible, your close vision gets worse. It's a condition called presbyopia, and it may make you wonder if you need reading glasses.",
            imageURL: "https://img.staging.medscape.com/pi/logos/books.jpg",
            detail: "Age has an effect on your eyes just like it does on your joints and other parts of your body. When you reach your 40s, the natural internal lenses in your eyes become less flexible. They can't focus as easily from near to far vision like they could when you were younger."
        )
    }
}
