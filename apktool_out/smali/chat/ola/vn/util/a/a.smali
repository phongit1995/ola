.class public Lchat/ola/vn/util/a/a;
.super Ljava/lang/Object;


# direct methods
.method public static a(II)I
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0x9
    .end annotation

    invoke-static {}, Lcom/mg/ola/common/d/g;->a()Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Landroid/hardware/Camera$CameraInfo;

    invoke-direct {v0}, Landroid/hardware/Camera$CameraInfo;-><init>()V

    invoke-static {p1, v0}, Landroid/hardware/Camera;->getCameraInfo(ILandroid/hardware/Camera$CameraInfo;)V

    iget p1, v0, Landroid/hardware/Camera$CameraInfo;->facing:I

    const/4 v1, 0x1

    if-ne p1, v1, :cond_0

    iget p1, v0, Landroid/hardware/Camera$CameraInfo;->orientation:I

    add-int/2addr p1, p0

    rem-int/lit16 p1, p1, 0x168

    rsub-int p0, p1, 0x168

    rem-int/lit16 p0, p0, 0x168

    return p0

    :cond_0
    iget p1, v0, Landroid/hardware/Camera$CameraInfo;->orientation:I

    sub-int/2addr p1, p0

    add-int/lit16 p1, p1, 0x168

    rem-int/lit16 p0, p1, 0x168

    return p0

    :cond_1
    const/4 p0, 0x0

    return p0
.end method

.method public static a(Landroid/app/Activity;)I
    .locals 1

    invoke-virtual {p0}, Landroid/app/Activity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object p0

    invoke-interface {p0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object p0

    invoke-virtual {p0}, Landroid/view/Display;->getRotation()I

    move-result p0

    const/4 v0, 0x0

    packed-switch p0, :pswitch_data_0

    return v0

    :pswitch_0
    const/16 p0, 0x10e

    return p0

    :pswitch_1
    const/16 p0, 0xb4

    return p0

    :pswitch_2
    const/16 p0, 0x5a

    return p0

    :pswitch_3
    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static a(Landroid/graphics/Matrix;ZIII)V
    .locals 1

    const/high16 v0, 0x3f800000    # 1.0f

    if-eqz p1, :cond_0

    const/high16 p1, -0x40800000    # -1.0f

    goto :goto_0

    :cond_0
    const/high16 p1, 0x3f800000    # 1.0f

    :goto_0
    invoke-virtual {p0, p1, v0}, Landroid/graphics/Matrix;->setScale(FF)V

    int-to-float p1, p2

    invoke-virtual {p0, p1}, Landroid/graphics/Matrix;->postRotate(F)Z

    int-to-float p1, p3

    const/high16 p2, 0x44fa0000    # 2000.0f

    div-float p3, p1, p2

    int-to-float p4, p4

    div-float p2, p4, p2

    invoke-virtual {p0, p3, p2}, Landroid/graphics/Matrix;->postScale(FF)Z

    const/high16 p2, 0x40000000    # 2.0f

    div-float/2addr p1, p2

    div-float/2addr p4, p2

    invoke-virtual {p0, p1, p4}, Landroid/graphics/Matrix;->postTranslate(FF)Z

    return-void
.end method
