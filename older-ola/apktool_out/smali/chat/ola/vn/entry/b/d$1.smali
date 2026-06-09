.class Lchat/ola/vn/entry/b/d$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/d;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c;

.field final synthetic b:Lchat/ola/vn/entry/b/d;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/d;Lchat/ola/vn/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/d$1;->b:Lchat/ola/vn/entry/b/d;

    iput-object p2, p0, Lchat/ola/vn/entry/b/d$1;->a:Lchat/ola/vn/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1

    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    if-nez p2, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p1, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/entry/b/d$1;->b:Lchat/ola/vn/entry/b/d;

    iget-object p2, p2, Lchat/ola/vn/entry/b/d;->s:Lchat/ola/vn/message/v;

    invoke-virtual {p2}, Lchat/ola/vn/message/v;->i()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->l(Ljava/lang/String;)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object p2, p0, Lchat/ola/vn/entry/b/d$1;->b:Lchat/ola/vn/entry/b/d;

    iget-object p2, p2, Lchat/ola/vn/entry/b/d;->s:Lchat/ola/vn/message/v;

    invoke-virtual {p2}, Lchat/ola/vn/message/v;->i()Ljava/lang/String;

    move-result-object p2

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Lchat/ola/vn/message/g;->a(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    iget-object p1, p0, Lchat/ola/vn/entry/b/d$1;->a:Lchat/ola/vn/c;

    invoke-virtual {p1}, Lchat/ola/vn/c;->finish()V

    :cond_0
    return-void
.end method
