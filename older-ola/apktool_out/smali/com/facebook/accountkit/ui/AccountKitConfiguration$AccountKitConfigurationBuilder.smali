.class public Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/facebook/accountkit/ui/AccountKitConfiguration;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "AccountKitConfigurationBuilder"
.end annotation


# instance fields
.field private defaultCountryCode:Ljava/lang/String;

.field private initialAuthState:Ljava/lang/String;

.field private initialEmail:Ljava/lang/String;

.field private initialPhoneNumber:Lcom/facebook/accountkit/PhoneNumber;

.field private loginType:Lcom/facebook/accountkit/ui/LoginType;

.field private final notificationChannels:Ljava/util/LinkedHashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashSet<",
            "Lcom/facebook/accountkit/ui/NotificationChannel;",
            ">;"
        }
    .end annotation
.end field

.field private readPhoneStateEnabled:Z

.field private receiveSMSEnabled:Z

.field private responseType:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

.field private smsBlacklist:[Ljava/lang/String;

.field private smsWhitelist:[Ljava/lang/String;

.field private theme:I
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end field

.field private uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;


# direct methods
.method public constructor <init>(Lcom/facebook/accountkit/ui/LoginType;Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-static {}, Lcom/facebook/accountkit/ui/NotificationChannel;->values()[Lcom/facebook/accountkit/ui/NotificationChannel;

    move-result-object v1

    array-length v1, v1

    invoke-direct {v0, v1}, Ljava/util/LinkedHashSet;-><init>(I)V

    iput-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->readPhoneStateEnabled:Z

    iput-boolean v0, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->receiveSMSEnabled:Z

    const/4 v0, -0x1

    iput v0, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->theme:I

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    sget-object v1, Lcom/facebook/accountkit/ui/NotificationChannel;->FACEBOOK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {v0, v1}, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    sget-object v1, Lcom/facebook/accountkit/ui/NotificationChannel;->VOICE_CALLBACK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {v0, v1}, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->loginType:Lcom/facebook/accountkit/ui/LoginType;

    iput-object p2, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->responseType:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    return-void
.end method


# virtual methods
.method public build()Lcom/facebook/accountkit/ui/AccountKitConfiguration;
    .locals 18

    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    if-nez v1, :cond_0

    new-instance v1, Lcom/facebook/accountkit/ui/ThemeUIManager;

    iget v2, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->theme:I

    invoke-direct {v1, v2}, Lcom/facebook/accountkit/ui/ThemeUIManager;-><init>(I)V

    iput-object v1, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    goto :goto_0

    :cond_0
    iget v1, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->theme:I

    const/4 v2, -0x1

    if-eq v1, v2, :cond_1

    iget-object v1, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    instance-of v1, v1, Lcom/facebook/accountkit/ui/SkinManager;

    if-eqz v1, :cond_1

    iget-object v1, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    check-cast v1, Lcom/facebook/accountkit/ui/UIManager;

    iget v2, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->theme:I

    invoke-interface {v1, v2}, Lcom/facebook/accountkit/ui/UIManager;->setThemeId(I)V

    :cond_1
    :goto_0
    iget-object v1, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    instance-of v1, v1, Lcom/facebook/accountkit/ui/AdvancedUIManager;

    if-eqz v1, :cond_2

    new-instance v1, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;

    iget-object v2, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    check-cast v2, Lcom/facebook/accountkit/ui/AdvancedUIManager;

    iget v3, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->theme:I

    invoke-direct {v1, v2, v3}, Lcom/facebook/accountkit/ui/AdvancedUIManagerWrapper;-><init>(Lcom/facebook/accountkit/ui/AdvancedUIManager;I)V

    iput-object v1, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    :cond_2
    new-instance v1, Lcom/facebook/accountkit/ui/AccountKitConfiguration;

    iget-object v2, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    move-object v5, v2

    check-cast v5, Lcom/facebook/accountkit/ui/UIManager;

    iget-object v6, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->defaultCountryCode:Ljava/lang/String;

    iget-object v7, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    iget-object v8, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->initialAuthState:Ljava/lang/String;

    iget-object v9, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->initialEmail:Ljava/lang/String;

    iget-object v10, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->initialPhoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    iget-object v11, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->loginType:Lcom/facebook/accountkit/ui/LoginType;

    iget-boolean v12, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->readPhoneStateEnabled:Z

    iget-boolean v13, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->receiveSMSEnabled:Z

    iget-object v14, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->responseType:Lcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;

    iget-object v15, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->smsBlacklist:[Ljava/lang/String;

    iget-object v2, v0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->smsWhitelist:[Ljava/lang/String;

    const/16 v17, 0x0

    move-object v4, v1

    move-object/from16 v16, v2

    invoke-direct/range {v4 .. v17}, Lcom/facebook/accountkit/ui/AccountKitConfiguration;-><init>(Lcom/facebook/accountkit/ui/UIManager;Ljava/lang/String;Ljava/util/LinkedHashSet;Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/PhoneNumber;Lcom/facebook/accountkit/ui/LoginType;ZZLcom/facebook/accountkit/ui/AccountKitActivity$ResponseType;[Ljava/lang/String;[Ljava/lang/String;Lcom/facebook/accountkit/ui/AccountKitConfiguration$1;)V

    return-object v1
.end method

.method public setAdvancedUIManager(Lcom/facebook/accountkit/ui/AdvancedUIManager;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/AdvancedUIManager;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    const/4 p1, -0x1

    iput p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->theme:I

    return-object p0
.end method

.method public setDefaultCountryCode(Ljava/lang/String;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->defaultCountryCode:Ljava/lang/String;

    return-object p0
.end method

.method public setFacebookNotificationsEnabled(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    sget-object v0, Lcom/facebook/accountkit/ui/NotificationChannel;->FACEBOOK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p1, v0}, Ljava/util/LinkedHashSet;->remove(Ljava/lang/Object;)Z

    return-object p0

    :cond_0
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    sget-object v0, Lcom/facebook/accountkit/ui/NotificationChannel;->FACEBOOK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p1, v0}, Ljava/util/LinkedHashSet;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    sget-object v0, Lcom/facebook/accountkit/ui/NotificationChannel;->FACEBOOK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p1, v0}, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z

    :cond_1
    return-object p0
.end method

.method public setInitialAuthState(Ljava/lang/String;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->initialAuthState:Ljava/lang/String;

    return-object p0
.end method

.method public setInitialEmail(Ljava/lang/String;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0
    .param p1    # Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->initialEmail:Ljava/lang/String;

    return-object p0
.end method

.method public setInitialPhoneNumber(Lcom/facebook/accountkit/PhoneNumber;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0
    .param p1    # Lcom/facebook/accountkit/PhoneNumber;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->initialPhoneNumber:Lcom/facebook/accountkit/PhoneNumber;

    return-object p0
.end method

.method public setReadPhoneStateEnabled(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->readPhoneStateEnabled:Z

    return-object p0
.end method

.method public setReceiveSMS(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0

    iput-boolean p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->receiveSMSEnabled:Z

    return-object p0
.end method

.method public setSMSBlacklist([Ljava/lang/String;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0
    .param p1    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->smsBlacklist:[Ljava/lang/String;

    return-object p0
.end method

.method public setSMSWhitelist([Ljava/lang/String;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0
    .param p1    # [Ljava/lang/String;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->smsWhitelist:[Ljava/lang/String;

    return-object p0
.end method

.method public setTheme(I)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0

    iput p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->theme:I

    return-object p0
.end method

.method public setTitleType(Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/AccountKitActivity$TitleType;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    return-object p0
.end method

.method public setUIManager(Lcom/facebook/accountkit/ui/UIManager;)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 0
    .param p1    # Lcom/facebook/accountkit/ui/UIManager;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    iput-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->uiManager:Lcom/facebook/accountkit/ui/UIManagerStub;

    const/4 p1, -0x1

    iput p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->theme:I

    return-object p0
.end method

.method public setVoiceCallbackNotificationsEnabled(Z)Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;
    .locals 1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    sget-object v0, Lcom/facebook/accountkit/ui/NotificationChannel;->VOICE_CALLBACK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p1, v0}, Ljava/util/LinkedHashSet;->remove(Ljava/lang/Object;)Z

    return-object p0

    :cond_0
    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    sget-object v0, Lcom/facebook/accountkit/ui/NotificationChannel;->VOICE_CALLBACK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p1, v0}, Ljava/util/LinkedHashSet;->contains(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/facebook/accountkit/ui/AccountKitConfiguration$AccountKitConfigurationBuilder;->notificationChannels:Ljava/util/LinkedHashSet;

    sget-object v0, Lcom/facebook/accountkit/ui/NotificationChannel;->VOICE_CALLBACK:Lcom/facebook/accountkit/ui/NotificationChannel;

    invoke-virtual {p1, v0}, Ljava/util/LinkedHashSet;->add(Ljava/lang/Object;)Z

    :cond_1
    return-object p0
.end method
