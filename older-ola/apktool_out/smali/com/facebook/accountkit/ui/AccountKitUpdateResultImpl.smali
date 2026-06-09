.class Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/AccountKitUpdateResult;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final cancelled:Z

.field private final error:Lcom/facebook/accountkit/AccountKitError;
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation
.end field

.field private final finalAuthorizationState:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->finalAuthorizationState:Ljava/lang/String;

    const-class v0, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/AccountKitError;

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1}, Landroid/os/Parcel;->readByte()B

    move-result p1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->cancelled:Z

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/facebook/accountkit/AccountKitError;Z)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p3, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->cancelled:Z

    iput-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->finalAuthorizationState:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getError()Lcom/facebook/accountkit/AccountKitError;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    return-object v0
.end method

.method public getFinalAuthorizationState()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->finalAuthorizationState:Ljava/lang/String;

    return-object v0
.end method

.method public wasCancelled()Z
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->finalAuthorizationState:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    iget-boolean p2, p0, Lcom/facebook/accountkit/ui/AccountKitUpdateResultImpl;->cancelled:Z

    int-to-byte p2, p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeByte(B)V

    return-void
.end method
