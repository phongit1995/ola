.class Lchat/ola/vn/view/e$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/view/e;->g()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/view/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/view/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    packed-switch p3, :pswitch_data_0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    goto :goto_1

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    const/16 p2, 0x9

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p2

    :goto_0
    invoke-static {p1, p2}, Lchat/ola/vn/view/e;->a(Lchat/ola/vn/view/e;Ljava/lang/Short;)Ljava/lang/Short;

    goto :goto_2

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    const/16 p2, 0x8

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p2

    goto :goto_0

    :pswitch_2
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    const/4 p2, 0x7

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p2

    goto :goto_0

    :pswitch_3
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    const/4 p2, 0x6

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p2

    goto :goto_0

    :pswitch_4
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    const/4 p2, 0x5

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p2

    goto :goto_0

    :pswitch_5
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    const/4 p2, 0x4

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p2

    goto :goto_0

    :pswitch_6
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    const/4 p2, 0x3

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p2

    goto :goto_0

    :pswitch_7
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/view/e;->a(Lchat/ola/vn/view/e;Ljava/lang/Short;)Ljava/lang/Short;

    goto :goto_2

    :goto_1
    const/16 p2, 0xa

    invoke-static {p2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object p2

    goto :goto_0

    :goto_2
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    invoke-static {p1}, Lchat/ola/vn/view/e;->e(Lchat/ola/vn/view/e;)Ljava/lang/Short;

    move-result-object p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    invoke-static {p1}, Lchat/ola/vn/view/e;->f(Lchat/ola/vn/view/e;)Landroid/widget/TextView;

    move-result-object p1

    const-string p2, "\u221e"

    :goto_3
    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    invoke-static {p1}, Lchat/ola/vn/view/e;->f(Lchat/ola/vn/view/e;)Landroid/widget/TextView;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, ""

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lchat/ola/vn/view/e$3;->a:Lchat/ola/vn/view/e;

    invoke-static {p3}, Lchat/ola/vn/view/e;->e(Lchat/ola/vn/view/e;)Ljava/lang/Short;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    :catch_0
    return-void

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
