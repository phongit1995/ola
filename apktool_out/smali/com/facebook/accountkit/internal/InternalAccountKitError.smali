.class public final Lcom/facebook/accountkit/internal/InternalAccountKitError;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CALLBACK_WITHOUT_ACTIVITY:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final CANNOT_CONSTRUCT_MESSAGE_BODY:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final CANNOT_CONSTRUCT_URL:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final CANNOT_RETRIEVE_ACCESS_TOKEN_NO_ACCOUNT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/internal/InternalAccountKitError;",
            ">;"
        }
    .end annotation
.end field

.field public static final DIFFERENT_LOGIN_ATTEMPT_IN_PROGRESS:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final EXPIRED_EMAIL_REQUEST:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_ACCESS_TOKEN_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_API_PARAMETERS:I = 0x64

.field public static final INVALID_APP_ID:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_APP_NAME:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_BACKGROUND_CONTRACT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_CLIENT_TOKEN:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_CONFIRMATION_CODE:I = 0x3a9b

.field public static final INVALID_CREDENTIALS_OR_LOGIN_REQUEST:I = 0x1db962

.field public static final INVALID_GRAPH_RESPONSE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_GRAPH_RESULTS_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_INTENT_EXTRAS_CONFIGURATION:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_INTENT_EXTRAS_LOGIN_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_INTENT_EXTRAS_RESPONSE_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_LOGIN_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_PARAMETER_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final INVALID_PHONE_NUMBER:I = 0x25d

.field public static final INVALID_PHONE_NUMBER_SERVER_CODE:I = 0x17a6b1

.field public static final LOGIN_REQUEST_EXPIRED:I = 0x1db961

.field public static final NOT_EQUAL_OBJECTS:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final NO_ACCOUNT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final NO_LOGIN_ATTEMPT_IN_PROGRESS:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final NO_NATIVE_APP_INSTALLED:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final NO_NETWORK_CONNECTION:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final NO_NETWORK_CONNECTION_CODE:I = 0x65

.field public static final NO_RESULT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final OPERATION_NOT_SUCCESSFUL:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final SDK_NOT_INITIALIZED:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final TOO_MANY_ATTEMPTS:I = 0x1db963

.field public static final UNEXPECTED_FRAGMENT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final UNEXPECTED_OBJECT_TYPE_RESPONSE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final UNEXPECTED_STATE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

.field public static final UNKNOWN_ERROR_CODE:I = -0x1

.field public static final UNSUPPORTED_NATIVE_APP_VERSION:Lcom/facebook/accountkit/internal/InternalAccountKitError;


# instance fields
.field private final subCode:I

.field private final subMessage:Ljava/lang/String;

.field private userFacingMessage:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "No network connection detected"

    const/16 v2, 0x65

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_NETWORK_CONNECTION:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "No response found"

    const/16 v2, 0xc9

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_RESULT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Invalid format of graph response to call"

    const/16 v2, 0xca

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESULTS_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "No account found"

    const/16 v2, 0x12d

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_ACCOUNT_FOUND:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Email login request expired"

    const/16 v2, 0x12e

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->EXPIRED_EMAIL_REQUEST:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Could not construct URL for request"

    const/16 v2, 0x191

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->CANNOT_CONSTRUCT_URL:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Could not construct request body"

    const/16 v2, 0x194

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->CANNOT_CONSTRUCT_MESSAGE_BODY:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Callback issues while activity not available"

    const/16 v2, 0x195

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->CALLBACK_WITHOUT_ACTIVITY:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "No access token: cannot retrieve account"

    const/16 v2, 0x196

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->CANNOT_RETRIEVE_ACCESS_TOKEN_NO_ACCOUNT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Unknown AccessToken serialization format"

    const/16 v2, 0x197

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_ACCESS_TOKEN_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Expected a single response"

    const/16 v2, 0x198

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESPONSE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Unexpected object type in response, class: "

    const/16 v2, 0x199

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->UNEXPECTED_OBJECT_TYPE_RESPONSE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Unexpected fragment type: "

    const/16 v2, 0x19a

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->UNEXPECTED_FRAGMENT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Unexpected login status"

    const/16 v2, 0x19b

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->UNEXPECTED_STATE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Operation not successful"

    const/16 v2, 0x19c

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->OPERATION_NOT_SUCCESSFUL:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "The SDK has not been initialized, make sure to call AccountKit.initialize() first"

    const/16 v2, 0x1f5

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->SDK_NOT_INITIALIZED:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "The App Id must be specified in the string resource file as com.facebook.sdk.ApplicationId"

    const/16 v2, 0x1f6

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_APP_ID:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "The Client Token must be specified in the string resource file as com.facebook.accountkit.ClientToken"

    const/16 v2, 0x1f7

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_CLIENT_TOKEN:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "The App Name must be specified in the string resource file as com.facebook.accountkit.ApplicationName"

    const/16 v2, 0x1f8

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_APP_NAME:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Configuration must be supplied as part of the intent"

    const/16 v2, 0x1f9

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_INTENT_EXTRAS_CONFIGURATION:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Login Type must be supplied as part of the configuration"

    const/16 v2, 0x1fa

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_INTENT_EXTRAS_LOGIN_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Response Type must be supplied as part of the configuration"

    const/16 v2, 0x1fb

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_INTENT_EXTRAS_RESPONSE_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Login type must be either PHONE_NUMBER or EMAIL"

    const/16 v2, 0x1fc

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_LOGIN_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "The provided com_accountkit_text_color and it\'s background do not contrast enough to be easily visible."

    const/16 v2, 0x1fd

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_BACKGROUND_CONTRACT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "No login request currently in progress"

    const/16 v2, 0x259

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_LOGIN_ATTEMPT_IN_PROGRESS:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Cannot perform operation while different login request in progress"

    const/16 v2, 0x25a

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->DIFFERENT_LOGIN_ATTEMPT_IN_PROGRESS:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "The following types not equal: "

    const/16 v2, 0x25b

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NOT_EQUAL_OBJECTS:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Invalid parameter type"

    const/16 v2, 0x25c

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_PARAMETER_TYPE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "No native app installed"

    const/16 v2, 0x2bd

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->NO_NATIVE_APP_INSTALLED:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    const-string v1, "Unsupported native app version"

    const/16 v2, 0x2be

    invoke-direct {v0, v2, v1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;)V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->UNSUPPORTED_NATIVE_APP_VERSION:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    new-instance v0, Lcom/facebook/accountkit/internal/InternalAccountKitError$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/internal/InternalAccountKitError$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subCode:I

    invoke-static {p2}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    move-object p2, v0

    :cond_0
    iput-object p2, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subMessage:Ljava/lang/String;

    invoke-static {p3}, Lcom/facebook/accountkit/internal/Utility;->isNullOrEmpty(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    move-object p3, v0

    :cond_1
    iput-object p3, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->userFacingMessage:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subCode:I

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subMessage:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->userFacingMessage:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/facebook/accountkit/internal/InternalAccountKitError$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/InternalAccountKitError;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method varargs constructor <init>(Lcom/facebook/accountkit/internal/InternalAccountKitError;[Ljava/lang/Object;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iget v0, p1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subCode:I

    iput v0, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subCode:I

    iget-object p1, p1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subMessage:Ljava/lang/String;

    invoke-static {p1, p2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subMessage:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getCode()I
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subCode:I

    return v0
.end method

.method getMessage()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subMessage:Ljava/lang/String;

    return-object v0
.end method

.method public getUserFacingMessage()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->userFacingMessage:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget v1, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subCode:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subMessage:Ljava/lang/String;

    if-eqz v1, :cond_0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subMessage:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    const-string v1, ""

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->userFacingMessage:Ljava/lang/String;

    if-eqz v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->userFacingMessage:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    :cond_1
    const-string v1, ""

    :goto_1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 0

    iget p2, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subCode:I

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->subMessage:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/InternalAccountKitError;->userFacingMessage:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
