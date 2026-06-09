.class Lchat/ola/vn/util/http/WebAppInterfaceImp$7;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/http/WebAppInterfaceImp;->getHtmlFromPage(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/util/http/WebAppInterfaceImp;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$7;->b:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iput-object p2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$7;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$7;->b:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$7;->a:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/b;->o(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method
