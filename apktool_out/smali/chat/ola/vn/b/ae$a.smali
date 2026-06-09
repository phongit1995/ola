.class Lchat/ola/vn/b/ae$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/ae;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Landroid/widget/ImageView;

.field b:Landroid/widget/ImageView;

.field final synthetic c:Lchat/ola/vn/b/ae;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/ae;Landroid/view/View;)V
    .locals 2

    iput-object p1, p0, Lchat/ola/vn/b/ae$a;->c:Lchat/ola/vn/b/ae;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const v0, 0x7f09027c

    invoke-virtual {p2, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    iget-object v0, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    iget v1, p1, Lchat/ola/vn/b/ae;->a:I

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setMaxHeight(I)V

    iget-object v0, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    iget p1, p1, Lchat/ola/vn/b/ae;->a:I

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setMaxWidth(I)V

    const p1, 0x7f090272

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/b/ae$a;->b:Landroid/widget/ImageView;

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/b/ae$a;->c:Lchat/ola/vn/b/ae;

    invoke-static {v0}, Lchat/ola/vn/b/ae;->a(Lchat/ola/vn/b/ae;)Landroid/view/View$OnClickListener;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/ae$a;->b:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/b/ae$a;->b:Landroid/widget/ImageView;

    new-instance v2, Lchat/ola/vn/b/ae$a$1;

    invoke-direct {v2, p0, p1}, Lchat/ola/vn/b/ae$a$1;-><init>(Lchat/ola/vn/b/ae$a;Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/ae$a;->b:Landroid/widget/ImageView;

    const/4 v2, 0x4

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    const/4 v2, 0x0

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    invoke-static {p1}, Lchat/ola/vn/util/o;->g(Ljava/lang/String;)S

    move-result v0

    packed-switch v0, :pswitch_data_0

    iget-object p1, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    const v0, 0x7f080775

    :goto_1
    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :pswitch_0
    iget-object p1, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    const v0, 0x7f080717

    goto :goto_1

    :pswitch_1
    iget-object p1, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    const v0, 0x7f08071a

    goto :goto_1

    :pswitch_2
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0, p1}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    iget-object p1, p0, Lchat/ola/vn/b/ae$a;->a:Landroid/widget/ImageView;

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/b/ae$a;->c:Lchat/ola/vn/b/ae;

    iget v0, v0, Lchat/ola/vn/b/ae;->a:I

    invoke-static {p1, v0}, Lchat/ola/vn/c/f;->g(Ljava/lang/String;I)Lchat/ola/vn/c/f;

    move-result-object p1

    new-instance v0, Lchat/ola/vn/b/ae$a$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/b/ae$a$2;-><init>(Lchat/ola/vn/b/ae$a;)V

    invoke-virtual {p1, v0}, Lchat/ola/vn/c/f;->a(Lchat/ola/vn/c/g;)V

    :try_start_0
    new-instance v0, Lchat/ola/vn/c/e;

    invoke-direct {v0}, Lchat/ola/vn/c/e;-><init>()V

    const/4 v2, 0x1

    new-array v2, v2, [Lchat/ola/vn/c/f;

    aput-object p1, v2, v1

    invoke-virtual {v0, v2}, Lchat/ola/vn/c/e;->a([Lchat/ola/vn/c/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
