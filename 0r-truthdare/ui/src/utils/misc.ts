interface CustomWindow extends Window {
  invokeNative?: unknown;
}

// Will return whether the current environment is in a regular browser
// and not CEF
export const isEnvBrowser = (): boolean =>
  !(window as CustomWindow).invokeNative;

// Basic no operation function
export const noop = (): void => {};

export function debugLog(error: any, functionName?: string) {
  const now = new Date();
  const timestamp = now.toISOString();
  const errorMessage = error.message || "No Message.";
  const errorStack = error.stack || "No Stack.";

  const logMessage = `
    Info: ${functionName ?? "?"},
    Time: ${timestamp}
    Error Message: ${errorMessage}
    Error Stack Trace: ${errorStack}
    Error: ${error}
  `;
  console.error(logMessage);
}

export function formatNumberWithComma(number: number) {
  number = number ?? 0;
  return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

export function getFormattedDate(date?: number) {
  const options: Intl.DateTimeFormatOptions = {
    weekday: "short",
    day: "numeric",
    month: "short",
    hour: "2-digit",
    minute: "2-digit",
    hour12: false,
  };

  const formattedDate = new Intl.DateTimeFormat("default", options).format(
    date ?? new Date()
  );

  return formattedDate;
}

export const getDateTimeDifference = (
  timestamp: number
): { days: number; hours: number } => {
  const currentDate = new Date();
  const sentDate = new Date(timestamp);

  const differenceInMilliseconds = Math.abs(
    currentDate.getTime() - sentDate.getTime()
  );
  const daysDifference = Math.floor(
    differenceInMilliseconds / (1000 * 60 * 60 * 24)
  );
  const hoursDifference = Math.floor(
    (differenceInMilliseconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
  );

  return { days: daysDifference, hours: hoursDifference };
};

let timeoutId: ReturnType<typeof setTimeout> | null;
export const debounce = <T extends (...args: any[]) => void>(
  func: T,
  wait: number
) => {
  return (...args: Parameters<T>) => {
    const later = () => {
      timeoutId = null;
      func(...args);
    };

    clearTimeout(timeoutId as ReturnType<typeof setTimeout>);
    timeoutId = setTimeout(later, wait);
  };
};

export const categoryColors: string[] = [
  "#FFF2CB",
  "#FFDBD2",
  "#FFBCBC",
  "#FFD4EE",
  "#CEDFFF",
  "#FFDBBA",
  "#C2E2FF",
];
