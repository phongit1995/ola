.class Lchat/ola/vn/b/y$a$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/b/y$a;->a(Lchat/ola/vn/entity/s;Lchat/ola/vn/entity/s;Lchat/ola/vn/entity/s;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/b/y$a;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/y$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/y$a$1;->a:Lchat/ola/vn/b/y$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    const-string v0, "0"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_0
    const-string v0, "1"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->b(Landroid/content/Context;)V

    return-void

    :cond_1
    const-string v0, "2"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->c(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/activity/OlaPhoneVerificationActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
