.class Lchat/ola/vn/game/caro/CaroActivity$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/game/caro/CaroActivity;->b(Ljava/lang/String;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/game/caro/CaroActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/game/caro/CaroActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity$5;->a:Lchat/ola/vn/game/caro/CaroActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4

    const/4 v0, 0x2

    const/4 v1, 0x0

    packed-switch p2, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    :try_start_0
    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_0

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/game/caro/CaroActivity;->C()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p2, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->v(Ljava/lang/String;S)V

    :cond_0
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-static {}, Lchat/ola/vn/game/caro/CaroActivity;->C()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/game/caro/b;->h()V

    goto :goto_0

    :pswitch_1
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-static {}, Lchat/ola/vn/game/caro/CaroActivity;->C()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p2, v2, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/game/caro/b;->j()V

    iget-object p2, p0, Lchat/ola/vn/game/caro/CaroActivity$5;->a:Lchat/ola/vn/game/caro/CaroActivity;

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-static {}, Lchat/ola/vn/game/caro/CaroActivity;->C()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->Q()Lchat/ola/vn/game/caro/b;

    move-result-object v1

    invoke-static {p2, v1}, Lchat/ola/vn/game/caro/CaroActivity;->a(Lchat/ola/vn/game/caro/CaroActivity;Lchat/ola/vn/game/caro/b;)Lchat/ola/vn/game/caro/b;

    iget-object p2, p0, Lchat/ola/vn/game/caro/CaroActivity$5;->a:Lchat/ola/vn/game/caro/CaroActivity;

    invoke-static {p2}, Lchat/ola/vn/game/caro/CaroActivity;->d(Lchat/ola/vn/game/caro/CaroActivity;)V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_1

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/game/caro/CaroActivity;->C()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v1, v0}, Lchat/ola/vn/network/OlaNetworkService;->u(Ljava/lang/String;S)V

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/game/caro/CaroActivity$5;->a:Lchat/ola/vn/game/caro/CaroActivity;

    invoke-static {p2}, Lchat/ola/vn/game/caro/CaroActivity;->e(Lchat/ola/vn/game/caro/CaroActivity;)Lchat/ola/vn/game/caro/d;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/game/caro/d;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p2

    invoke-virtual {p2}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
