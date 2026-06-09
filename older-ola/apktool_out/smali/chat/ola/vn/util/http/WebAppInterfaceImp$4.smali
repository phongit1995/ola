.class Lchat/ola/vn/util/http/WebAppInterfaceImp$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/http/WebAppInterfaceImp;->requestShowPostMeRssForm(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Lchat/ola/vn/util/http/WebAppInterfaceImp;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->d:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iput-object p2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->c:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->d:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iget-object v1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->a:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$200(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->d:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v1}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->d:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iget-object v3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->b:Ljava/lang/String;

    invoke-static {v2, v3}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$200(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->d:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iget-object v4, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->c:Ljava/lang/String;

    invoke-static {v3, v4}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$200(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3, v0}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->d:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->d:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->b:Ljava/lang/String;

    invoke-static {v1, v2}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$200(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->d:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iget-object v3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;->c:Ljava/lang/String;

    invoke-static {v2, v3}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$200(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/4 v3, 0x0

    invoke-static {v0, v1, v2, v3}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
