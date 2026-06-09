.class Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/AccountKitLoginResult;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final accessToken:Lcom/facebook/accountkit/AccessToken;

.field private final authorizationCode:Ljava/lang/String;

.field private final cancelled:Z

.field private final error:Lcom/facebook/accountkit/AccountKitError;

.field private final finalAuthorizationState:Ljava/lang/String;

.field private final tokenRefreshIntervalInSeconds:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-class v0, Lcom/facebook/accountkit/AccessToken;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/AccessToken;

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->accessToken:Lcom/facebook/accountkit/AccessToken;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->authorizationCode:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->finalAuthorizationState:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->tokenRefreshIntervalInSeconds:J

    const-class v0, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/AccountKitError;

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1}, Landroid/os/Parcel;->readByte()B

    move-result p1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->cancelled:Z

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/AccessToken;Ljava/lang/String;Ljava/lang/String;JLcom/facebook/accountkit/AccountKitError;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->accessToken:Lcom/facebook/accountkit/AccessToken;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->authorizationCode:Ljava/lang/String;

    iput-wide p4, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->tokenRefreshIntervalInSeconds:J

    iput-boolean p7, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->cancelled:Z

    iput-object p6, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    iput-object p3, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->finalAuthorizationState:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getAccessToken()Lcom/facebook/accountkit/AccessToken;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->accessToken:Lcom/facebook/accountkit/AccessToken;

    return-object v0
.end method

.method public getAuthorizationCode()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->authorizationCode:Ljava/lang/String;

    return-object v0
.end method

.method public getError()Lcom/facebook/accountkit/AccountKitError;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    return-object v0
.end method

.method public getFinalAuthorizationState()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->finalAuthorizationState:Ljava/lang/String;

    return-object v0
.end method

.method public getTokenRefreshIntervalInSeconds()J
    .locals 2

    iget-wide v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->tokenRefreshIntervalInSeconds:J

    return-wide v0
.end method

.method public wasCancelled()Z
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->authorizationCode:Ljava/lang/String;

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->accessToken:Lcom/facebook/accountkit/AccessToken;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->accessToken:Lcom/facebook/accountkit/AccessToken;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->authorizationCode:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->finalAuthorizationState:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-wide v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->tokenRefreshIntervalInSeconds:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    iget-boolean p2, p0, Lcom/facebook/accountkit/ui/AccountKitLoginResultImpl;->cancelled:Z

    int-to-byte p2, p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeByte(B)V

    return-void
.end method
