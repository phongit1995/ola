.class Lchat/ola/vn/activity/OlaLoginActivity$8;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/a/a/p$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaLoginActivity;->I()Lchat/ola/vn/network/a/a/p$a;
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

    iput-object p1, p0, Lchat/ola/vn/activity/OlaLoginActivity$8;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Ljava/util/List;)V
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    if-eqz p2, :cond_1

    :try_start_0
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$8;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    const v1, 0x7f0f05fd

    invoke-static {v0, p1, p2, v1}, Lchat/ola/vn/activity/OlaRecoveredAccountListActivity;->a(Landroid/app/Activity;Ljava/lang/String;Ljava/util/List;I)V

    return-void

    :cond_0
    const/4 v0, 0x0

    invoke-interface {p2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaLoginActivity$8;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Lchat/ola/vn/activity/OlaLoginActivity;Z)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaLoginActivity$8;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {v1}, Lchat/ola/vn/activity/OlaLoginActivity;->n(Lchat/ola/vn/activity/OlaLoginActivity;)Lchat/ola/vn/network/a/a/ai$a;

    move-result-object v1

    invoke-virtual {v0, p2, p1, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/network/a/a/ai$a;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaLoginActivity$8;->a:Lchat/ola/vn/activity/OlaLoginActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/signup/OlaSignUpActivity;->a(Lchat/ola/vn/c;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
