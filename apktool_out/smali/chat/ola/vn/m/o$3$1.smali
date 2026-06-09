.class Lchat/ola/vn/m/o$3$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o$3;->onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/o$3;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o$3;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$3$1;->a:Lchat/ola/vn/m/o$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-nez p2, :cond_0

    :try_start_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, p0, Lchat/ola/vn/m/o$3$1;->a:Lchat/ola/vn/m/o$3;

    iget-object v0, v0, Lchat/ola/vn/m/o$3;->b:Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v0

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->e(J)V

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v0, p0, Lchat/ola/vn/m/o$3$1;->a:Lchat/ola/vn/m/o$3;

    iget-object v0, v0, Lchat/ola/vn/m/o$3;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p2, v0}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;

    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
