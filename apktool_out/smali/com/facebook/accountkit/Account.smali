.class public final Lcom/facebook/accountkit/Account;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/Account;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final email:Ljava/lang/String;

.field private final id:Ljava/lang/String;

.field private final phoneNumber:Lcom/facebook/accountkit/PhoneNumber;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/Account$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/Account$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/Account;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/Account;->id:Ljava/lang/String;

    const-class v0, Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/PhoneNumber;

    iput-object v0, p0, Lcom/facebook/accountkit/Account;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/Account;->email:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/facebook/accountkit/Account$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/Account;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/facebook/accountkit/PhoneNumber;Ljava/lang/String;)V
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p2    # Lcom/facebook/accountkit/PhoneNumber;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param
    .param p3    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/Account;->id:Ljava/lang/String;

    iput-object p2, p0, Lcom/facebook/accountkit/Account;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    iput-object p3, p0, Lcom/facebook/accountkit/Account;->email:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/facebook/accountkit/Account;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    check-cast p1, Lcom/facebook/accountkit/Account;

    iget-object v1, p0, Lcom/facebook/accountkit/Account;->email:Ljava/lang/String;

    iget-object v3, p1, Lcom/facebook/accountkit/Account;->email:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/Account;->id:Ljava/lang/String;

    iget-object v3, p1, Lcom/facebook/accountkit/Account;->id:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/Account;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    iget-object p1, p1, Lcom/facebook/accountkit/Account;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-static {v1, p1}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    return v0

    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public getEmail()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/Account;->email:Ljava/lang/String;

    return-object v0
.end method

.method public getId()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/Account;->id:Ljava/lang/String;

    return-object v0
.end method

.method public getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/Account;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/Account;->email:Ljava/lang/String;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->getHashCode(Ljava/lang/Object;)I

    move-result v0

    const/16 v1, 0x20f

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-object v0, p0, Lcom/facebook/accountkit/Account;->id:Ljava/lang/String;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->getHashCode(Ljava/lang/Object;)I

    move-result v0

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-object v0, p0, Lcom/facebook/accountkit/Account;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-static {v0}, Lcom/facebook/accountkit/internal/Utility;->getHashCode(Ljava/lang/Object;)I

    move-result v0

    add-int/2addr v1, v0

    return v1
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/Account;->id:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/Account;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    iget-object p2, p0, Lcom/facebook/accountkit/Account;->email:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    return-void
.end method
