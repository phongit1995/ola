.class public Lchat/ola/vn/util/d/a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/hardware/SensorEventListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/util/d/a$a;
    }
.end annotation


# instance fields
.field private a:Landroid/hardware/SensorManager;

.field private b:F

.field private c:F

.field private d:F

.field private e:J

.field private f:Lchat/ola/vn/util/d/a$a;

.field private g:Landroid/content/Context;

.field private h:I

.field private i:J

.field private j:J


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/high16 v0, -0x40800000    # -1.0f

    iput v0, p0, Lchat/ola/vn/util/d/a;->b:F

    iput v0, p0, Lchat/ola/vn/util/d/a;->c:F

    iput v0, p0, Lchat/ola/vn/util/d/a;->d:F

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/util/d/a;->h:I

    iput-object p1, p0, Lchat/ola/vn/util/d/a;->g:Landroid/content/Context;

    invoke-virtual {p0}, Lchat/ola/vn/util/d/a;->a()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/d/a;->g:Landroid/content/Context;

    const-string v1, "sensor"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lchat/ola/vn/util/d/a;->a:Landroid/hardware/SensorManager;

    iget-object v0, p0, Lchat/ola/vn/util/d/a;->a:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/util/d/a;->a:Landroid/hardware/SensorManager;

    iget-object v1, p0, Lchat/ola/vn/util/d/a;->a:Landroid/hardware/SensorManager;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v1

    const/4 v2, 0x3

    invoke-virtual {v0, p0, v1, v2}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/util/d/a;->a:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/util/d/a$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/d/a;->f:Lchat/ola/vn/util/d/a$a;

    return-void
.end method

.method public b()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/d/a;->a:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/util/d/a;->a:Landroid/hardware/SensorManager;

    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/util/d/a;->a:Landroid/hardware/SensorManager;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0

    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 13

    :try_start_0
    iget-object v0, p1, Landroid/hardware/SensorEvent;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v0}, Landroid/hardware/Sensor;->getType()I

    move-result v0

    const/4 v1, 0x1

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Lchat/ola/vn/util/d/a;->e:J

    const/4 v0, 0x0

    sub-long v6, v2, v4

    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v4, 0x0

    aget v0, v0, v4

    iget v5, p0, Lchat/ola/vn/util/d/a;->b:F

    sub-float/2addr v0, v5

    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v0

    iget-object v5, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v5, v5, v1

    iget v8, p0, Lchat/ola/vn/util/d/a;->c:F

    sub-float/2addr v5, v8

    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v5

    add-float/2addr v0, v5

    iget-object v5, p1, Landroid/hardware/SensorEvent;->values:[F

    const/4 v8, 0x2

    aget v5, v5, v8

    iget v9, p0, Lchat/ola/vn/util/d/a;->d:F

    sub-float/2addr v5, v9

    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v5

    add-float/2addr v0, v5

    iget-wide v9, p0, Lchat/ola/vn/util/d/a;->j:J

    const/4 v5, 0x0

    sub-long v11, v2, v9

    const-wide/16 v9, 0x1f4

    cmp-long v5, v11, v9

    if-lez v5, :cond_1

    iput v4, p0, Lchat/ola/vn/util/d/a;->h:I

    :cond_1
    iget-wide v9, p0, Lchat/ola/vn/util/d/a;->e:J

    const/4 v5, 0x0

    sub-long v11, v2, v9

    const-wide/16 v9, 0x64

    cmp-long v5, v11, v9

    if-lez v5, :cond_4

    long-to-float v5, v6

    div-float/2addr v0, v5

    const v5, 0x461c4000    # 10000.0f

    mul-float v0, v0, v5

    const/high16 v5, 0x44960000    # 1200.0f

    cmpl-float v0, v0, v5

    if-lez v0, :cond_3

    iget v0, p0, Lchat/ola/vn/util/d/a;->h:I

    add-int/2addr v0, v1

    iput v0, p0, Lchat/ola/vn/util/d/a;->h:I

    const/4 v5, 0x5

    if-lt v0, v5, :cond_2

    iget-wide v5, p0, Lchat/ola/vn/util/d/a;->i:J

    const/4 v0, 0x0

    sub-long v9, v2, v5

    const-wide/16 v5, 0x3e8

    cmp-long v0, v9, v5

    if-lez v0, :cond_2

    iput-wide v2, p0, Lchat/ola/vn/util/d/a;->i:J

    iput v4, p0, Lchat/ola/vn/util/d/a;->h:I

    iget-object v0, p0, Lchat/ola/vn/util/d/a;->f:Lchat/ola/vn/util/d/a$a;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/util/d/a;->f:Lchat/ola/vn/util/d/a$a;

    invoke-interface {v0}, Lchat/ola/vn/util/d/a$a;->a()V

    :cond_2
    iput-wide v2, p0, Lchat/ola/vn/util/d/a;->j:J

    :cond_3
    iput-wide v2, p0, Lchat/ola/vn/util/d/a;->e:J

    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v0, v0, v4

    iput v0, p0, Lchat/ola/vn/util/d/a;->b:F

    iget-object v0, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v0, v0, v1

    iput v0, p0, Lchat/ola/vn/util/d/a;->c:F

    iget-object p1, p1, Landroid/hardware/SensorEvent;->values:[F

    aget p1, p1, v8

    iput p1, p0, Lchat/ola/vn/util/d/a;->d:F
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_4
    return-void
.end method
