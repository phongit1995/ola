.class public final Lcom/facebook/accountkit/internal/EmailLoginModelImpl;
.super Lcom/facebook/accountkit/internal/LoginModelImpl;

# interfaces
.implements Lcom/facebook/accountkit/EmailLoginModel;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/internal/EmailLoginModelImpl;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private email:Ljava/lang/String;

.field private interval:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 5

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/LoginModelImpl;-><init>(Landroid/os/Parcel;)V

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->email:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    iput v0, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->interval:I

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->fields:Ljava/util/Map;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->fields:Ljava/util/Map;

    invoke-interface {v4, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/facebook/accountkit/internal/EmailLoginModelImpl$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p2}, Lcom/facebook/accountkit/internal/LoginModelImpl;-><init>(Ljava/lang/String;)V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->email:Ljava/lang/String;

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
    instance-of v1, p1, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;

    invoke-super {p0, p1}, Lcom/facebook/accountkit/internal/LoginModelImpl;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget p1, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->interval:I

    iget v3, v1, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->interval:I

    if-ne p1, v3, :cond_2

    iget-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->email:Ljava/lang/String;

    iget-object v1, v1, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->email:Ljava/lang/String;

    invoke-static {p1, v1}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    return v0

    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public bridge synthetic getAccessToken()Lcom/facebook/accountkit/AccessToken;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-super {p0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getAccessToken()Lcom/facebook/accountkit/AccessToken;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getCode()Ljava/lang/String;
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getCode()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getEmail()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->email:Ljava/lang/String;

    return-object v0
.end method

.method public bridge synthetic getError()Lcom/facebook/accountkit/AccountKitError;
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getError()Lcom/facebook/accountkit/AccountKitError;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getFinalAuthState()Ljava/lang/String;
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getFinalAuthState()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getInitialAuthState()Ljava/lang/String;
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getInitialAuthState()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getInterval()I
    .locals 1

    iget v0, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->interval:I

    return v0
.end method

.method public bridge synthetic getPrivacyPolicy()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-super {p0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getPrivacyPolicy()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getResponseType()Ljava/lang/String;
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getResponseType()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getStatus()Lcom/facebook/accountkit/internal/LoginStatus;
    .locals 1

    invoke-super {p0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getStatus()Lcom/facebook/accountkit/internal/LoginStatus;

    move-result-object v0

    return-object v0
.end method

.method public bridge synthetic getTermsOfService()Ljava/lang/String;
    .locals 1
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    invoke-super {p0}, Lcom/facebook/accountkit/internal/LoginModelImpl;->getTermsOfService()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method setEmail(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->email:Ljava/lang/String;

    return-void
.end method

.method setInterval(I)V
    .locals 0

    iput p1, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->interval:I

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 2

    invoke-super {p0, p1, p2}, Lcom/facebook/accountkit/internal/LoginModelImpl;->writeToParcel(Landroid/os/Parcel;I)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->email:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget p2, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->interval:I

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->fields:Ljava/util/Map;

    invoke-interface {p2}, Ljava/util/Map;->size()I

    move-result p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->fields:Ljava/util/Map;

    invoke-interface {p2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_0
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/EmailLoginModelImpl;->fields:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    return-void
.end method
