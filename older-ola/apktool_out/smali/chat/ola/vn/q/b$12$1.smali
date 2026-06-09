.class Lchat/ola/vn/q/b$12$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/q/b$12;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/q/b$12;


# direct methods
.method constructor <init>(Lchat/ola/vn/q/b$12;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/q/b$12$1;->a:Lchat/ola/vn/q/b$12;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-nez p2, :cond_0

    :try_start_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/q/b$12$1;->a:Lchat/ola/vn/q/b$12;

    iget-object v0, v0, Lchat/ola/vn/q/b$12;->c:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/q/b$12$1;->a:Lchat/ola/vn/q/b$12;

    iget-object v1, v1, Lchat/ola/vn/q/b$12;->f:Ljava/lang/String;

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->g(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
