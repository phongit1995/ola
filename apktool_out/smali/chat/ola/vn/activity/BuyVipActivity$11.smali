.class Lchat/ola/vn/activity/BuyVipActivity$11;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/BuyVipActivity;->f(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/activity/BuyVipActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/BuyVipActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->c:Lchat/ola/vn/activity/BuyVipActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/sms/b;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->c:Lchat/ola/vn/activity/BuyVipActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/BuyVipActivity;->a(Lchat/ola/vn/activity/BuyVipActivity;Z)V

    iget-object v0, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->c:Lchat/ola/vn/activity/BuyVipActivity;

    iget-object v1, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->c:Lchat/ola/vn/activity/BuyVipActivity;

    const v2, 0x7f0f00a2

    invoke-virtual {v1, v2}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->b:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    const-wide/16 v0, 0x0

    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->a:Ljava/lang/String;

    const-string v3, "8555"

    invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-wide/16 v0, 0x1388

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->a:Ljava/lang/String;

    const-string v3, "8655"

    invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    const-wide/16 v0, 0x2710

    goto :goto_0

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity$11;->a:Ljava/lang/String;

    const-string v3, "8755"

    invoke-virtual {v2, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    const-wide/16 v0, 0x3a98

    :cond_2
    :goto_0
    const-wide/16 v2, 0x28

    mul-long v0, v0, v2

    const-wide/16 v2, 0x64

    div-long/2addr v0, v2

    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v2

    const-string v3, "Buy VIP by SMS"

    invoke-virtual {v2, v3, v0, v1}, Lchat/ola/vn/util/f;->a(Ljava/lang/String;J)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_3
    return-void
.end method
