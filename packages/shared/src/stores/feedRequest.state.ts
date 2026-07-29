const requestIds = {
  clan: 0,
  me: 0,
};

export function nextClanFeedRequestId(): number {
  requestIds.clan += 1;
  return requestIds.clan;
}

export function currentClanFeedRequestId(): number {
  return requestIds.clan;
}

export function nextMeFeedRequestId(): number {
  requestIds.me += 1;
  return requestIds.me;
}

export function currentMeFeedRequestId(): number {
  return requestIds.me;
}
