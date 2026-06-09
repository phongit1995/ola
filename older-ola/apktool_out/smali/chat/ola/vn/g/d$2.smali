.class Lchat/ola/vn/g/d$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/g/d;->a(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/g/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/g/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/g/d$2;->a:Lchat/ola/vn/g/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    if-nez p2, :cond_1

    move-object p2, p1

    check-cast p2, Lchat/ola/vn/i/p;

    invoke-virtual {p2}, Lchat/ola/vn/i/p;->a()Ljava/lang/String;

    move-result-object p2

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/g/d$2;->a:Lchat/ola/vn/g/d;

    iget-object v1, v1, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1, p2}, Lchat/ola/vn/network/OlaNetworkService;->c(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/g/d$2;->a:Lchat/ola/vn/g/d;

    iget-object v0, v0, Lchat/ola/vn/g/d;->d:Lchat/ola/vn/message/f;

    invoke-virtual {v0, p2}, Lchat/ola/vn/message/f;->b(Ljava/lang/String;)V

    :cond_1
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
