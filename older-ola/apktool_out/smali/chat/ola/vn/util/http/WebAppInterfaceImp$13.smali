.class Lchat/ola/vn/util/http/WebAppInterfaceImp$13;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/http/WebAppInterfaceImp;->sendSms(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/util/http/WebAppInterfaceImp;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$13;->c:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iput-object p2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$13;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$13;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->x()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$13;->c:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$13;->c:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$13;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$13;->b:Ljava/lang/String;

    invoke-static {v0, v1, v2}, Lchat/ola/vn/sms/OlaSmsSendingActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
