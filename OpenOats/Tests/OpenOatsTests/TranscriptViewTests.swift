import XCTest
@testable import OpenOatsKit

final class TranscriptViewTests: XCTestCase {
    func testEmptyStateForChunkedTranscriptionExplainsPause() {
        let emptyState = TranscriptView.emptyState(
            hasTranscript: false,
            hasVolatileTranscript: false,
            isSearching: false,
            isRunning: true,
            usesChunkedTranscription: true,
            transcriptionModelName: "ElevenLabs Scribe"
        )

        XCTAssertEqual(
            emptyState,
            TranscriptView.EmptyState(
                title: "Waiting for first transcript chunk",
                detail: "ElevenLabs Scribe sends transcript updates after a short pause in speech.",
                showsProgress: true
            )
        )
    }

    func testEmptyStateForLocalTranscriptionShowsListening() {
        let emptyState = TranscriptView.emptyState(
            hasTranscript: false,
            hasVolatileTranscript: false,
            isSearching: false,
            isRunning: true,
            usesChunkedTranscription: false,
            transcriptionModelName: "Parakeet TDT v3"
        )

        XCTAssertEqual(
            emptyState,
            TranscriptView.EmptyState(
                title: "Listening for speech",
                detail: "The live transcript will appear here as speech is detected.",
                showsProgress: true
            )
        )
    }

    func testEmptyStateWhileIdleInvitesUserToStartRecording() {
        let emptyState = TranscriptView.emptyState(
            hasTranscript: false,
            hasVolatileTranscript: false,
            isSearching: false,
            isRunning: false,
            usesChunkedTranscription: false,
            transcriptionModelName: ""
        )

        XCTAssertEqual(
            emptyState,
            TranscriptView.EmptyState(
                title: "Transcript will appear here",
                detail: "Start recording to see live speech transcribed during your meeting.",
                showsProgress: false
            )
        )
    }

    func testEmptyStateIsNilWhenSearchingOrTranscriptAlreadyVisible() {
        XCTAssertNil(
            TranscriptView.emptyState(
                hasTranscript: true,
                hasVolatileTranscript: false,
                isSearching: false,
                isRunning: true,
                usesChunkedTranscription: true,
                transcriptionModelName: "ElevenLabs Scribe"
            )
        )

        XCTAssertNil(
            TranscriptView.emptyState(
                hasTranscript: false,
                hasVolatileTranscript: true,
                isSearching: false,
                isRunning: true,
                usesChunkedTranscription: true,
                transcriptionModelName: "ElevenLabs Scribe"
            )
        )

        XCTAssertNil(
            TranscriptView.emptyState(
                hasTranscript: false,
                hasVolatileTranscript: false,
                isSearching: true,
                isRunning: true,
                usesChunkedTranscription: true,
                transcriptionModelName: "ElevenLabs Scribe"
            )
        )
    }
}
