.class Lchat/ola/vn/m/o$4$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o$4;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/o$4;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o$4;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$4$1;->a:Lchat/ola/vn/m/o$4;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-nez p2, :cond_1

    :try_start_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_0

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/m/o$4$1;->a:Lchat/ola/vn/m/o$4;

    iget-object v0, v0, Lchat/ola/vn/m/o$4;->b:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/network/OlaNetworkService;->k(Ljava/lang/String;)V

    :cond_0
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v0, p0, Lchat/ola/vn/m/o$4$1;->a:Lchat/ola/vn/m/o$4;

    iget-object v0, v0, Lchat/ola/vn/m/o$4;->b:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x2

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;S)Lchat/ola/vn/message/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
