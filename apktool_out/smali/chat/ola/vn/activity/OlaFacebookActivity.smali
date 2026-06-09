.class public Lchat/ola/vn/activity/OlaFacebookActivity;
.super Lchat/ola/vn/c;

# interfaces
.implements Lchat/ola/vn/f/a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/activity/OlaFacebookActivity$a;,
        Lchat/ola/vn/activity/OlaFacebookActivity$b;
    }
.end annotation


# static fields
.field public static e:Ljava/lang/String; = null

.field public static f:Z = false

.field private static g:Lcom/facebook/CallbackManager;

.field private static h:Lchat/ola/vn/activity/OlaFacebookActivity$b;

.field private static i:Lchat/ola/vn/activity/OlaFacebookActivity$a;


# instance fields
.field private j:Lcom/facebook/FacebookCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/facebook/FacebookCallback<",
            "Lcom/facebook/login/LoginResult;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    new-instance v0, Lchat/ola/vn/activity/OlaFacebookActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaFacebookActivity$1;-><init>(Lchat/ola/vn/activity/OlaFacebookActivity;)V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaFacebookActivity;->j:Lcom/facebook/FacebookCallback;

    return-void
.end method

.method public static B()Z
    .locals 1

    :try_start_0
    const-string v0, "publish_actions"

    invoke-static {v0}, Lchat/ola/vn/activity/OlaFacebookActivity;->f(Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method private C()V
    .locals 4

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/AccessToken;->isExpired()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-static {}, Lcom/facebook/login/LoginManager;->getInstance()Lcom/facebook/login/LoginManager;

    move-result-object v0

    const/4 v1, 0x4

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "email"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    const-string v3, "public_profile"

    aput-object v3, v1, v2

    const/4 v2, 0x2

    const-string v3, "user_friends"

    aput-object v3, v1, v2

    const/4 v2, 0x3

    const-string v3, "user_birthday"

    aput-object v3, v1, v2

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Lcom/facebook/login/LoginManager;->logInWithReadPermissions(Landroid/app/Activity;Ljava/util/Collection;)V

    :cond_1
    return-void
.end method

.method private D()V
    .locals 4

    :try_start_0
    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/AccessToken;->isExpired()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/activity/OlaFacebookActivity;->B()Z

    move-result v0

    const/4 v1, 0x1

    if-nez v0, :cond_0

    invoke-static {}, Lcom/facebook/login/LoginManager;->getInstance()Lcom/facebook/login/LoginManager;

    move-result-object v0

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "publish_actions"

    aput-object v3, v1, v2

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, p0, v1}, Lcom/facebook/login/LoginManager;->logInWithPublishPermissions(Landroid/app/Activity;Ljava/util/Collection;)V

    return-void

    :cond_0
    sput-boolean v1, Lchat/ola/vn/activity/OlaFacebookActivity;->f:Z

    sget-object v0, Lchat/ola/vn/activity/OlaFacebookActivity;->h:Lchat/ola/vn/activity/OlaFacebookActivity$b;

    invoke-interface {v0}, Lchat/ola/vn/activity/OlaFacebookActivity$b;->a()V

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaFacebookActivity;->finish()V

    return-void

    :cond_1
    sget-object v0, Lchat/ola/vn/activity/OlaFacebookActivity;->h:Lchat/ola/vn/activity/OlaFacebookActivity$b;

    invoke-interface {v0}, Lchat/ola/vn/activity/OlaFacebookActivity$b;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    return-void
.end method

.method public static a(Landroid/content/Context;Landroid/os/Bundle;Lchat/ola/vn/activity/OlaFacebookActivity$a;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaFacebookActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    sput-object p2, Lchat/ola/vn/activity/OlaFacebookActivity;->i:Lchat/ola/vn/activity/OlaFacebookActivity$a;

    const/4 p2, 0x0

    sput-object p2, Lchat/ola/vn/activity/OlaFacebookActivity;->h:Lchat/ola/vn/activity/OlaFacebookActivity$b;

    if-eqz p1, :cond_0

    invoke-virtual {v0, p1}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    :cond_0
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/activity/OlaFacebookActivity$b;)V
    .locals 2

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/activity/OlaFacebookActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v1, 0x10000000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const/4 v1, 0x0

    sput-object v1, Lchat/ola/vn/activity/OlaFacebookActivity;->i:Lchat/ola/vn/activity/OlaFacebookActivity$a;

    sput-object p1, Lchat/ola/vn/activity/OlaFacebookActivity;->h:Lchat/ola/vn/activity/OlaFacebookActivity$b;

    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaFacebookActivity;Lcom/facebook/login/LoginResult;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaFacebookActivity;->a(Lcom/facebook/login/LoginResult;)V

    return-void
.end method

.method private a(Lcom/facebook/login/LoginResult;)V
    .locals 0

    :try_start_0
    sget-object p1, Lchat/ola/vn/activity/OlaFacebookActivity;->h:Lchat/ola/vn/activity/OlaFacebookActivity$b;

    if-eqz p1, :cond_1

    invoke-static {}, Lchat/ola/vn/activity/OlaFacebookActivity;->B()Z

    move-result p1

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/activity/OlaFacebookActivity;->h:Lchat/ola/vn/activity/OlaFacebookActivity$b;

    invoke-interface {p1}, Lchat/ola/vn/activity/OlaFacebookActivity$b;->a()V

    goto :goto_0

    :cond_0
    sget-object p1, Lchat/ola/vn/activity/OlaFacebookActivity;->h:Lchat/ola/vn/activity/OlaFacebookActivity$b;

    invoke-interface {p1}, Lchat/ola/vn/activity/OlaFacebookActivity$b;->b()V

    :cond_1
    :goto_0
    sget-object p1, Lchat/ola/vn/activity/OlaFacebookActivity;->i:Lchat/ola/vn/activity/OlaFacebookActivity$a;

    if-eqz p1, :cond_2

    sget-object p1, Lchat/ola/vn/activity/OlaFacebookActivity;->i:Lchat/ola/vn/activity/OlaFacebookActivity$a;

    invoke-interface {p1}, Lchat/ola/vn/activity/OlaFacebookActivity$a;->a()V

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/activity/OlaFacebookActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static f(Ljava/lang/String;)Z
    .locals 1

    :try_start_0
    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/AccessToken;->getPermissions()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0, p0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    const/4 p0, 0x0

    return p0
.end method


# virtual methods
.method protected a()V
    .locals 0

    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1

    invoke-super {p0, p1, p2, p3}, Lchat/ola/vn/c;->onActivityResult(IILandroid/content/Intent;)V

    :try_start_0
    sget-object v0, Lchat/ola/vn/activity/OlaFacebookActivity;->g:Lcom/facebook/CallbackManager;

    invoke-interface {v0, p1, p2, p3}, Lcom/facebook/CallbackManager;->onActivityResult(IILandroid/content/Intent;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b00a3

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaFacebookActivity;->setContentView(I)V

    :try_start_0
    invoke-static {}, Lcom/facebook/CallbackManager$Factory;->create()Lcom/facebook/CallbackManager;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/activity/OlaFacebookActivity;->g:Lcom/facebook/CallbackManager;

    invoke-static {}, Lcom/facebook/login/LoginManager;->getInstance()Lcom/facebook/login/LoginManager;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/activity/OlaFacebookActivity;->g:Lcom/facebook/CallbackManager;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaFacebookActivity;->j:Lcom/facebook/FacebookCallback;

    invoke-virtual {p1, v0, v1}, Lcom/facebook/login/LoginManager;->registerCallback(Lcom/facebook/CallbackManager;Lcom/facebook/FacebookCallback;)V

    sget-object p1, Lchat/ola/vn/activity/OlaFacebookActivity;->h:Lchat/ola/vn/activity/OlaFacebookActivity$b;

    if-eqz p1, :cond_0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaFacebookActivity;->D()V

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/activity/OlaFacebookActivity;->C()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method protected onDestroy()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/c;->onDestroy()V

    return-void
.end method
