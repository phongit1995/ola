.class Lchat/ola/vn/game/caro/CaroActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/game/caro/CaroActivity;->a(Lchat/ola/vn/game/caro/a;)V
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

    iput-object p1, p0, Lchat/ola/vn/game/caro/CaroActivity$3;->a:Lchat/ola/vn/game/caro/CaroActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2

    packed-switch p2, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    :try_start_0
    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-static {}, Lchat/ola/vn/game/caro/CaroActivity;->C()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/message/f;->R()V

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz p2, :cond_0

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {}, Lchat/ola/vn/game/caro/CaroActivity;->C()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x2

    invoke-virtual {p2, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->s(Ljava/lang/String;S)V

    goto :goto_0

    :pswitch_1
    iget-object p2, p0, Lchat/ola/vn/game/caro/CaroActivity$3;->a:Lchat/ola/vn/game/caro/CaroActivity;

    invoke-static {p2}, Lchat/ola/vn/game/caro/CaroActivity;->c(Lchat/ola/vn/game/caro/CaroActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p2

    invoke-virtual {p2}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
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
