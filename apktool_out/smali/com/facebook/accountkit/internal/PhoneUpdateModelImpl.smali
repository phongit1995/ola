.class final Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/facebook/accountkit/PhoneUpdateModel;


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private confirmationCode:Ljava/lang/String;

.field private error:Lcom/facebook/accountkit/AccountKitError;

.field private expiresInSeconds:J

.field private fields:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private finalUpdateState:Ljava/lang/String;

.field private initialUpdateState:Ljava/lang/String;

.field private phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

.field private resendTime:J

.field private status:Lcom/facebook/accountkit/internal/UpdateStatus;

.field private updateRequestCode:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl$1;

    invoke-direct {v0}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl$1;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method private constructor <init>(Landroid/os/Parcel;)V
    .locals 5

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/facebook/accountkit/internal/UpdateStatus;->EMPTY:Lcom/facebook/accountkit/internal/UpdateStatus;

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->status:Lcom/facebook/accountkit/internal/UpdateStatus;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

    const-class v0, Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/PhoneNumber;

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->resendTime:J

    invoke-virtual {p1}, Landroid/os/Parcel;->readLong()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->expiresInSeconds:J

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->confirmationCode:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->updateRequestCode:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->finalUpdateState:Ljava/lang/String;

    const-class v0, Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->readParcelable(Ljava/lang/ClassLoader;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Lcom/facebook/accountkit/AccountKitError;

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/accountkit/internal/UpdateStatus;->valueOf(Ljava/lang/String;)Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v0

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->status:Lcom/facebook/accountkit/internal/UpdateStatus;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

    invoke-virtual {p1}, Landroid/os/Parcel;->readInt()I

    move-result v0

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Landroid/os/Parcel;->readString()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

    invoke-interface {v4, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method synthetic constructor <init>(Landroid/os/Parcel;Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;-><init>(Landroid/os/Parcel;)V

    return-void
.end method

.method constructor <init>(Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget-object v0, Lcom/facebook/accountkit/internal/UpdateStatus;->EMPTY:Lcom/facebook/accountkit/internal/UpdateStatus;

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->status:Lcom/facebook/accountkit/internal/UpdateStatus;

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    return-void
.end method


# virtual methods
.method public describeContents()I
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 7

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    check-cast p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;

    iget-wide v3, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->expiresInSeconds:J

    iget-wide v5, p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->expiresInSeconds:J

    cmp-long v1, v3, v5

    if-nez v1, :cond_2

    iget-wide v3, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->resendTime:J

    iget-wide v5, p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->resendTime:J

    cmp-long v1, v3, v5

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->status:Lcom/facebook/accountkit/internal/UpdateStatus;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->status:Lcom/facebook/accountkit/internal/UpdateStatus;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->updateRequestCode:Ljava/lang/String;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->updateRequestCode:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->finalUpdateState:Ljava/lang/String;

    iget-object v3, p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->finalUpdateState:Ljava/lang/String;

    invoke-static {v1, v3}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->confirmationCode:Ljava/lang/String;

    iget-object p1, p1, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->confirmationCode:Ljava/lang/String;

    invoke-static {v1, p1}, Lcom/facebook/accountkit/internal/Utility;->areObjectsEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    return v0

    :cond_2
    const/4 v0, 0x0

    return v0
.end method

.method public getConfirmationCode()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->confirmationCode:Ljava/lang/String;

    return-object v0
.end method

.method public getError()Lcom/facebook/accountkit/AccountKitError;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    return-object v0
.end method

.method public getFinalUpdateState()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->finalUpdateState:Ljava/lang/String;

    return-object v0
.end method

.method public getInitialUpdateState()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->initialUpdateState:Ljava/lang/String;

    return-object v0
.end method

.method public getPhoneNumber()Lcom/facebook/accountkit/PhoneNumber;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    return-object v0
.end method

.method public getPrivacyPolicy()Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

    const-string v1, "privacy_policy"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getResendTime()J
    .locals 2

    iget-wide v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->resendTime:J

    return-wide v0
.end method

.method public getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->status:Lcom/facebook/accountkit/internal/UpdateStatus;

    return-object v0
.end method

.method public getTermsOfService()Ljava/lang/String;
    .locals 2
    .annotation build Landroid/support/annotation/Nullable;
    .end annotation

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

    const-string v1, "terms_of_service"

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getUpdateRequestCode()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->updateRequestCode:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {v0}, Lcom/facebook/accountkit/PhoneNumber;->hashCode()I

    move-result v0

    const/16 v1, 0x20f

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-wide v2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->resendTime:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->hashCode()I

    move-result v0

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-wide v2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->expiresInSeconds:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->hashCode()I

    move-result v0

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->status:Lcom/facebook/accountkit/internal/UpdateStatus;

    invoke-virtual {v0}, Lcom/facebook/accountkit/internal/UpdateStatus;->hashCode()I

    move-result v0

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->updateRequestCode:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->finalUpdateState:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    add-int/2addr v1, v0

    mul-int/lit8 v1, v1, 0x1f

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->confirmationCode:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    add-int/2addr v1, v0

    return v1
.end method

.method putField(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

    invoke-interface {v0, p1, p2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method setConfirmationCode(Ljava/lang/String;)V
    .locals 3

    invoke-virtual {p0}, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->getStatus()Lcom/facebook/accountkit/internal/UpdateStatus;

    move-result-object v0

    sget-object v1, Lcom/facebook/accountkit/internal/UpdateStatus;->PENDING:Lcom/facebook/accountkit/internal/UpdateStatus;

    const-string v2, "Phone status"

    invoke-static {v0, v1, v2}, Lcom/facebook/accountkit/internal/Validate;->isEquals(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {}, Lcom/facebook/accountkit/internal/Validate;->sdkInitialized()V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->confirmationCode:Ljava/lang/String;

    return-void
.end method

.method setError(Lcom/facebook/accountkit/AccountKitError;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    return-void
.end method

.method setExpiresInSeconds(J)V
    .locals 0

    iput-wide p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->expiresInSeconds:J

    return-void
.end method

.method setFinalUpdateState(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->finalUpdateState:Ljava/lang/String;

    return-void
.end method

.method setInitialUpdateState(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->initialUpdateState:Ljava/lang/String;

    return-void
.end method

.method setPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    return-void
.end method

.method setResendTime(J)V
    .locals 0

    iput-wide p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->resendTime:J

    return-void
.end method

.method setStatus(Lcom/facebook/accountkit/internal/UpdateStatus;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->status:Lcom/facebook/accountkit/internal/UpdateStatus;

    return-void
.end method

.method setUpdateRequestCode(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->updateRequestCode:Ljava/lang/String;

    return-void
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->phoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    iget-wide v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->resendTime:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    iget-wide v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->expiresInSeconds:J

    invoke-virtual {p1, v0, v1}, Landroid/os/Parcel;->writeLong(J)V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->confirmationCode:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->updateRequestCode:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->finalUpdateState:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->error:Lcom/facebook/accountkit/AccountKitError;

    invoke-virtual {p1, v0, p2}, Landroid/os/Parcel;->writeParcelable(Landroid/os/Parcelable;I)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->status:Lcom/facebook/accountkit/internal/UpdateStatus;

    invoke-virtual {p2}, Lcom/facebook/accountkit/internal/UpdateStatus;->name()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

    invoke-interface {p2}, Ljava/util/Map;->size()I

    move-result p2

    invoke-virtual {p1, p2}, Landroid/os/Parcel;->writeInt(I)V

    iget-object p2, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

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

    iget-object v1, p0, Lcom/facebook/accountkit/internal/PhoneUpdateModelImpl;->fields:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/os/Parcel;->writeString(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    return-void
.end method
