SELECT
    artist.id,
    artist.gid AS artist_gid,
    artist.name AS artist_name,
    artist.area,
    recording.name AS recording_name,
    recording.length,
    recording.gid AS recording_gid,
    recording.video
FROM
    `musicbrainz.artist` AS artist
INNER JOIN
    `musicbrainz.artist_credit_name` AS artist_credit_name
ON
    artist.id = artist_credit_name.artist
INNER JOIN
    `musicbrainz.recording` AS recording
ON
    artist_credit_name.artist_credit = recording.artist_credit
