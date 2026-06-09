.class public final Lcom/facebook/accountkit/AccountKitError;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/AccountKitError$Type;
    }
.end annotation


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/AccountKitError;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final errorType:Lcom/facebook/accountkit/AccountKitError$Type;

.field private final internalError:Lcom/facebook/accountkit/internal/InternalAccountKitError;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/AccountKitError$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/AccountKitError$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/AccountKitError;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-static {}, Lcom/facebook/accountkit/AccountKitError$Type;->values()[Lcom/facebook/accountkit/AccountKitError$Type;

    move-result-object v0

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v1

    aget-object v0, v0, v1

    iput-object v0, p0, Lcom/facebook/accountkit/AccountKitError;->errorType:Lcom/facebook/accountkit/AccountKitError$Type;

    const-class v0, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object p1

    check-cast p1, Lcom/facebook/accountkit/internal/InternalAccountKitError;

    iput-object p1, p0, Lcom/facebook/accountkit/AccountKitError;->internalError:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/facebook/accountkit/AccountKitError$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/AccountKitError;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/AccountKitError$Type;)V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/facebook/accountkit/AccountKitError;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/AccountKitError;->errorType:Lcom/facebook/accountkit/AccountKitError$Type;

    iput-object p2, p0, Lcom/facebook/accountkit/AccountKitError;->internalError:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public getDetailErrorCode()I
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/AccountKitError;->internalError:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    if-nez v0, :cond_0

    const/4 v0, -0x1

    return v0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/AccountKitError;->internalError:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/InternalAccountKitError;->getCode()I

    move-result v0

    return v0
.end method

.method public getErrorType()Lcom/facebook/accountkit/AccountKitError$Type;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/AccountKitError;->errorType:Lcom/facebook/accountkit/AccountKitError$Type;

    return-object v0
.end method

.method public getUserFacingMessage()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/AccountKitError;->internalError:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/AccountKitError;->internalError:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/InternalAccountKitError;->getUserFacingMessage()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/facebook/accountkit/AccountKitError;->errorType:Lcom/facebook/accountkit/AccountKitError$Type;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lcom/facebook/accountkit/AccountKitError;->internalError:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/AccountKitError;->errorType:Lcom/facebook/accountkit/AccountKitError$Type;

    invoke-virtual {v0}, Lcom/facebook/accountkit/AccountKitError$Type;->ordinal()I

    move-result v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeInt(I)V

    iget-object v0, p0, Lcom/facebook/accountkit/AccountKitError;->internalError:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    return-void
.end method
