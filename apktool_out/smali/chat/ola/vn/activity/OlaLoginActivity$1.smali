.class Lchat/ola/vn/activity/OlaLoginActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/activity/OlaLoginActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaLoginActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaLoginActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v0, p1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;Ljava/lang/String;)Ljava/lang/String;

    invoke-static {}, Lcom/facebook/AccessToken;->getCurrentAccessToken()Lcom/facebook/AccessToken;

    move-result-object v0

    invoke-virtual {v0}, Lcom/facebook/AccessToken;->getToken()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/network/c;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/l/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const v1, 0x7f0f0521

    invoke-virtual {v0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const v2, 0x7f0f0549

    invoke-virtual {v1, v2}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Z)V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    const v0, 0x7f0f0549

    const v1, 0x7f0f0521

    const/4 v2, 0x0

    if-eqz p1, :cond_1

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    if-lez v3, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v3

    const/4 v4, 0x1

    if-le v3, v4, :cond_0

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v3, v2}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;Z)V

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v3, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v3}, Lchat/ola/vn/activity/OlaLoginActivity;->b(Lchat/ola/vn/activity/OlaLoginActivity;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3, p1}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-virtual {v2, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    :goto_0
    invoke-virtual {v2, v0}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v1, v0}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaLoginActivity;->b(Lchat/ola/vn/activity/OlaLoginActivity;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/network/c;

    move-result-object v1

    invoke-static {v0, p1, v1}, Lchat/ola/vn/l/b;->d(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/c;)V

    goto :goto_1

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p1, v2}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaLoginActivity;->b(Lchat/ola/vn/activity/OlaLoginActivity;)Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lchat/ola/vn/signup/fb/OlaSignUpByFacebookActivity;->a(Landroid/content/Context;Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-virtual {v2, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    goto :goto_0

    :cond_2
    :goto_1
    const/16 p1, 0x4002

    sput-short p1, Lchat/ola/vn/c/x;->j:S

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    sget-short v0, Lchat/ola/vn/c/x;->j:S

    invoke-virtual {p1, v0}, Lchat/ola/vn/e;->d(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(S)V
    .locals 0

    return-void
.end method

.method public b()V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {p2}, Lchat/ola/vn/h;->b(Ljava/lang/String;)V

    :cond_0
    invoke-static {p3}, Lchat/ola/vn/h;->c(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/e;->a(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0, p3}, Lchat/ola/vn/e;->b(Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v0, p1, p2, p3, v1}, Lchat/ola/vn/h/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p2, p1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const-class p2, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Ljava/lang/Class;)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$1;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaLoginActivity;->finish()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public b(S)V
    .locals 0

    return-void
.end method

.method public c()V
    .locals 0

    return-void
.end method

.method public d()V
    .locals 0

    return-void
.end method
