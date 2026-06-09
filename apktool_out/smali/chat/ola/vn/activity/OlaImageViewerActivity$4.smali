.class Lchat/ola/vn/activity/OlaImageViewerActivity$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaImageViewerActivity;->v()Landroid/app/Dialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/mediastore/OlaMediaEntity;

.field final synthetic c:Lchat/ola/vn/activity/OlaImageViewerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaImageViewerActivity;Ljava/util/List;Lchat/ola/vn/mediastore/OlaMediaEntity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

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

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p3, 0x7f0f0614

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x1

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->d(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_0

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->c(Landroid/content/Context;Ljava/lang/String;)V

    :goto_0
    sput p3, Lchat/ola/vn/h;->G:I

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p4, 0x7f0f05b5

    invoke-virtual {p2, p4}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    const/4 p2, 0x0

    packed-switch p1, :pswitch_data_1

    goto :goto_1

    :pswitch_2
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iget-object p3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p3}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p3

    invoke-interface {p1, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-static {p3, p2, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->b(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)V

    goto :goto_1

    :pswitch_3
    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    iget-object p3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p3}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p3

    invoke-interface {p1, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p3, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    invoke-static {p3, p2, p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/util/List;)V

    :goto_1
    const/4 p1, 0x4

    :goto_2
    sput p1, Lchat/ola/vn/h;->G:I

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p4, 0x7f0f061e

    invoke-virtual {p2, p4}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p4, 0x3

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    packed-switch p1, :pswitch_data_2

    goto :goto_4

    :pswitch_4
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    :goto_3
    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->g(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_4

    :pswitch_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->h(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_4

    :pswitch_6
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lchat/ola/vn/entity/i;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    goto :goto_3

    :goto_4
    sput p4, Lchat/ola/vn/h;->G:I

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p5, 0x7f0f0620

    invoke-virtual {p2, p5}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    packed-switch p1, :pswitch_data_3

    goto :goto_5

    :pswitch_7
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->e(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_5

    :pswitch_8
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->f(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_5

    :pswitch_9
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->d(Landroid/content/Context;Ljava/lang/String;)V

    :goto_5
    const/4 p1, 0x6

    goto/16 :goto_2

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p5, 0x7f0f061d

    invoke-virtual {p2, p5}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_4

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    packed-switch p1, :pswitch_data_4

    goto :goto_6

    :pswitch_a
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_6

    :pswitch_b
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->c(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_6

    :pswitch_c
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    :goto_6
    const/4 p1, 0x7

    goto/16 :goto_2

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p5, 0x7f0f05f8

    invoke-virtual {p2, p5}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_7

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1}, Lchat/ola/vn/mediastore/OlaMediaEntity;->a()I

    move-result p1

    if-eq p1, p3, :cond_6

    if-eq p1, p4, :cond_5

    return-void

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->f(Ljava/lang/String;)V

    return-void

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p2}, Lchat/ola/vn/mediastore/OlaMediaEntity;->c()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/b/b;->a(Landroid/content/Context;Ljava/lang/String;)V

    const/4 p1, 0x0

    goto/16 :goto_2

    :cond_7
    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    const p3, 0x7f0f056b

    invoke-virtual {p2, p3}, Lchat/ola/vn/activity/OlaImageViewerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->c:Lchat/ola/vn/activity/OlaImageViewerActivity;

    iget-object p2, p0, Lchat/ola/vn/activity/OlaImageViewerActivity$4;->b:Lchat/ola/vn/mediastore/OlaMediaEntity;

    invoke-virtual {p1, p2}, Lchat/ola/vn/activity/OlaImageViewerActivity;->a(Lchat/ola/vn/mediastore/OlaMediaEntity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_8
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x1
        :pswitch_3
        :pswitch_2
    .end packed-switch

    :pswitch_data_2
    .packed-switch 0x1
        :pswitch_6
        :pswitch_5
        :pswitch_4
    .end packed-switch

    :pswitch_data_3
    .packed-switch 0x1
        :pswitch_9
        :pswitch_8
        :pswitch_7
    .end packed-switch

    :pswitch_data_4
    .packed-switch 0x1
        :pswitch_c
        :pswitch_b
        :pswitch_a
    .end packed-switch
.end method
