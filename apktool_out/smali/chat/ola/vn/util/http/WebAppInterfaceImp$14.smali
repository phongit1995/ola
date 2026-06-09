.class Lchat/ola/vn/util/http/WebAppInterfaceImp$14;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/http/WebAppInterfaceImp;->playYoutubes([Ljava/lang/String;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:[Ljava/lang/String;

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/util/http/WebAppInterfaceImp;


# direct methods
.method constructor <init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;[Ljava/lang/String;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$14;->c:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    iput-object p2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$14;->a:[Ljava/lang/String;

    iput p3, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$14;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$14;->c:Lchat/ola/vn/util/http/WebAppInterfaceImp;

    invoke-static {v0}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$14;->a:[Ljava/lang/String;

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    iget v2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp$14;->b:I

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/util/List;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method
